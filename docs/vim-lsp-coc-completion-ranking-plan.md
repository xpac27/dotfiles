# Coc-Style Completion Ranking for vim-lsp

Date audited: 2026-07-24

## Goal

Implement substantially better LSP completion ordering in `vim-lsp`, using the
useful behavior observed in Coc without copying Coc's implementation.

The first implementation should:

- rank strong textual matches ahead of weak ones;
- preserve the language server's `sortText` preference;
- use occurrences in the current buffer as a locality tie-breaker;
- work through both vim-lsp's native omnifunc and `asyncomplete-lsp.vim`;
- remain deterministic and fast for large clangd result sets;
- preserve all existing snippet, text-edit, resolve, and `user_data` behavior;
- be opt-in so existing vim-lsp users do not receive a silent ordering change.

This plan targets the separate plugin checkout at:

```text
/home/vinz/.vim/plugged/vim-lsp
```

Do not implement this in the dotfiles repository. This document is the
handoff; the implementation belongs on a feature branch in the vim-lsp
checkout.

## Pinned Investigation Inputs

The findings below were verified against these exact local revisions:

| Repository | Path | Commit | Date |
| --- | --- | --- | --- |
| Coc | `/tmp/coc.nvim` | `ec19c3ee067be597d02515c3b9e90fd0ddcf7a9e` | 2026-07-23 |
| vim-lsp | `/tmp/vim-lsp` | `474c656659b5fb51eec6770309e0211c8aa49b5b` | 2026-04-19 |
| Installed vim-lsp | `/home/vinz/.vim/plugged/vim-lsp` | `f11d480362aae8b09bca7609c05dfeaeba0aa6fa` | 2026-03-04 |

The installed checkout was clean during the audit, but it was about one month
behind the supplied vim-lsp clone. Start by updating it before relying on the
line numbers or tests in this plan.

Relevant dotfiles history:

- `4f56123` added the previous asyncomplete ranking experiment.
- `8dd6c45` introduced Coc.
- `1c23de7` merged `try-coc`.
- `origin/try-coc` is historical and already merged; do not treat it as the
  current dotfiles baseline.

## Executive Findings

Coc does not have one magic "smart completion" switch. Its observed quality is
the result of several separate stages:

1. fuzzy filtering produces a relevance score;
2. source priority separates LSP, snippets, buffer words, and other providers;
3. the server's `sortText` is respected within a source;
4. a scope-aware locality value breaks later ties;
5. deterministic fallback ordering uses label length or alphabetic order;
6. an optional in-memory MRU chooses which row is initially selected, but does
   not reorder the list.

The MRU distinction matters for this configuration. The checked-in Coc settings
contain:

```json
"suggest.localityBonus": true,
"suggest.noselect": true
```

They do not override `suggest.selection`, whose Coc default is `"first"`.
Furthermore, Coc only consults MRU when `noselect` is false. Therefore MRU did
not cause the better ordering observed with this dotfiles setup. The material
differences were fuzzy relevance, `sortText`, and locality.

## How Coc Actually Ranks Completion Items

### Collection and conversion

The main pipeline is in:

- `/tmp/coc.nvim/src/completion/complete.ts`
- `/tmp/coc.nvim/src/completion/util.ts`
- `/tmp/coc.nvim/src/completion/types.ts`

`Complete` sorts completion sources by descending source priority before
running them. Language/LSP sources default to priority `99`; other Coc sources
can define lower priorities.

Every source item is converted into a duration item containing at least:

- insertion `word`;
- display `abbr`;
- `filterText`;
- source and source priority;
- item-specific start character;
- `sortText`;
- LSP kind and snippet state;
- generated fuzzy score and locality bonus.

Items are deduplicated by inserted word unless their source/item explicitly
allows duplicates.

### Fuzzy relevance

The filtering path is `Complete.filterItems()` in
`src/completion/complete.ts`. It scores the typed input against `filterText`,
not blindly against the inserted word or display label.

With `suggest.filterGraceful` enabled and at most 2,000 candidates, Coc uses
`fuzzyScoreGracefulAggressive()` from `src/util/filter.ts`. Above 2,000 items,
or when graceful matching is disabled, it uses the strict `fuzzyScore()`.

The scorer is a bounded dynamic-programming matcher with a maximum considered
pattern/candidate length of 128 characters. Important scoring behavior:

- exact-case common-prefix characters receive the strongest reward;
- case-insensitive prefix matches receive a smaller reward;
- camel-case starts and separator boundaries are rewarded;
- contiguous matches receive a bonus;
- opening a gap and skipping characters are penalized;
- a complete full-string match receives an extra bonus;
- a weak first match is normally rejected;
- aggressive graceful matching tries up to seven adjacent-character
  permutations and penalizes a transposition.

The exact numeric implementation is not required for the vim-lsp port. Its
important user-visible properties are:

- full/prefix matches beat scattered subsequence matches;
- camel-case and separator-boundary matches are useful;
- shorter gaps beat longer gaps;
- case-correct matches tend to win;
- small adjacent typos can still match for normal-sized result sets.

### Final comparator

`sortItems()` in `src/completion/complete.ts` compares candidates in this
order:

1. fuzzy score, descending;
2. source priority, descending;
3. `sortText`, ascending, when both items came from the same source;
4. locality bonus, descending;
5. for empty input, item start character;
6. configured fallback: none, alphabetic, or label length.

Coc's default fallback is label length.

For vim-lsp, all items in one converted result belong to one language-server
source, so source priority is not part of the plugin-local comparator. Source
priority remains the completion frontend's responsibility when asyncomplete
merges LSP and buffer sources.

### Scope-aware locality

The implementation is in:

```text
/tmp/coc.nvim/src/completion/wordDistance.ts
```

Despite its name, Coc does not primarily calculate physical line distance.
It:

1. asks the language server for `textDocument/selectionRange` at the cursor;
2. builds the nested range chain from outer scope to inner scope;
3. ignores ranges spanning 2,000 lines or more;
4. computes occurrences of words inside the outer accepted scope, with a
   100 ms timeout;
5. removes the word currently being completed;
6. finds an occurrence for each candidate;
7. returns a scope-depth bucket: candidates present in the innermost scope are
   better than candidates found only in a parent scope;
8. gives keywords and snippets no locality bonus.

This frequently promotes locals because a local variable already occurs in the
current function or block, while an unrelated global does not.

There are graceful fallbacks. If locality is disabled, no selection-range
provider exists, the request is cancelled, or word indexing misses its
100 ms budget, the distance is neutral.

### Recently used selection

The relevant code is:

- `MruLoader` in `src/completion/util.ts`;
- popup selection in `src/completion/pum.ts`;
- recording in `Completion.addMruItem()` in `src/completion/index.ts`.

The cache:

- is in memory only;
- holds at most 100 entries;
- keys items by `filterText`, source name, and kind;
- tracks both global recency and prefix-specific recency;
- records a candidate after it was inserted or confirmed.

When `suggest.selection` is `recentlyUsed` or `recentlyUsedByPrefix`, Coc scans
the already-sorted list and selects the most recent matching row. It does not
move that row or change any candidate's rank.

MRU is skipped when:

- an LSP item has already been preselected;
- `suggest.noselect` is true;
- selection mode is `"first"`.

## What vim-lsp Does Today

The current implementation is concentrated in:

```text
autoload/lsp/omni.vim
autoload/lsp/ui/vim/completion.vim
test/lsp/omni.vimspec
doc/vim-lsp.txt
```

`lsp#omni#get_vim_completion_items()`:

- unwraps an LSP completion list;
- optionally sorts raw LSP items by `sortText`;
- converts them to Vim completion dictionaries;
- stores the original LSP item in an internal `user_data` map;
- returns `items`, `incomplete`, and `startcol`.

The existing sort is opt-in per server:

```vim
'config': { 'sort': { 'max': 100 } }
```

It has important limitations:

- it only compares `sortText`, falling back to label;
- it has no typed-input relevance score;
- it has no locality signal;
- it skips all sorting when the candidate count exceeds `max`;
- it sorts the response list in place;
- native filtering only supports prefix and contains matching;
- native completion currently handles only the first completion-capable server.

`autoload/lsp/ui/vim/completion.vim` already owns the `CompleteDone` hook needed
to apply text edits and snippets. It could record MRU safely, but Vim's native
popup API cannot directly preselect an arbitrary index the way Coc's custom
popup can.

## The asyncomplete Boundary

The previous vim-lsp setup also used:

```text
asyncomplete.vim
asyncomplete-lsp.vim
asyncomplete-buffer.vim
```

`asyncomplete-lsp.vim` calls
`lsp#omni#get_vim_completion_items()`, so ranking performed during conversion
is visible to that adapter.

The asyncomplete default preprocessor then uses Vim's `matchfuzzypos()` when it
is available. That is useful and should remain enabled.

However, dotfiles commit `4f56123` installed a custom preprocessor which:

1. called `matchfuzzypos()`;
2. discarded its numeric scores;
3. immediately sorted each source into coarse prefix groups and then
   alphabetically.

That final alphabetical sort destroys richer LSP ordering. Do not restore that
preprocessor unchanged when switching back from Coc.

Also note:

- `completeopt=nearest` only affects matches originating from the current
  buffer; it does not make LSP items local.
- `nearest` has no effect when `completeopt` contains `fuzzy`.
- merging and prioritizing LSP versus buffer sources belongs in asyncomplete,
  not vim-lsp.

## License Constraint

Do not copy or transliterate Coc's TypeScript fuzzy matcher.

The audited Coc checkout uses the Anti-996 License in `LICENSE.md`, while
vim-lsp uses the MIT License. A direct or close port would create licensing and
upstream-acceptance problems.

Implement from the behavioral specification in this document and use Vim's
existing `matchfuzzypos()` implementation. Do not copy Coc code, comments,
constant names, or numeric tables. No Coc entry should be added to
`LICENSE-THIRD-PARTY` unless code is actually copied; this plan specifically
forbids doing that.

## Recommended Design

### Configuration

Extend the existing per-server `sort` dictionary without changing its legacy
behavior.

Recommended new configuration:

```vim
'config': {
\   'filter': { 'name': 'fuzzy' },
\   'sort': {
\       'name': 'relevance',
\       'max': 2000,
\       'locality': v:true,
\   },
\ }
```

Semantics:

- absent `sort`: preserve current behavior;
- `sort` without `name`, or `name: 'sortText'`: preserve legacy `sortText`
  sorting and its `max` behavior;
- `name: 'relevance'`: use the new ranker;
- `max`: do not run the relevance ranker above this candidate count;
- `locality`: enable the synchronous buffer-occurrence tie-breaker;
- `filter.name: 'fuzzy'`: use fuzzy filtering for native omnifunc completion.

Do not silently enable relevance ranking for every existing vim-lsp user in
the first change.

### New ranking module

Create:

```text
autoload/lsp/internal/completion/ranking.vim
```

Keep ranking out of the already-large `autoload/lsp/omni.vim`.

Suggested internal entry point:

```vim
lsp#internal#completion#ranking#rank(items, context)
```

`items` should be a copied list of raw LSP `CompletionItem` dictionaries.
`context` should contain:

```vim
{
\ 'base': typed_text,
\ 'bufnr': bufnr('%'),
\ 'position': lsp_position,
\ 'start_character': completion_start_character,
\ 'locality': v:true,
\ }
```

Return a new ordered list. Do not mutate the server response.

Each temporary rank record should contain:

- original LSP item;
- original index;
- effective filter text: `filterText`, otherwise `label`;
- effective sort text: non-empty `sortText`, otherwise empty;
- fuzzy score;
- locality score;
- fallback label length.

Temporary score data must not leak into the LSP item or Vim completion item's
`user_data`.

### Fuzzy scoring

Use `matchfuzzypos()` with the effective filter text as the record key.

Important details:

- retain its returned numeric score, not only the reordered item list;
- retain nonmatching candidates at the end during sorting, because filtering
  is a separate policy;
- use the original index as the final stable tie-breaker;
- respect `g:lsp_ignorecase` in the non-fuzzy fallback;
- feature-detect `matchfuzzypos()` for compatibility.

Fallback when `matchfuzzypos()` is unavailable:

1. exact full match;
2. exact-case prefix;
3. case-insensitive prefix when `g:lsp_ignorecase` is true;
4. other candidates.

The first implementation does not need Coc's adjacent-transposition typo
logic. Vim's scorer is implemented in C, supports multibyte text, is already
used elsewhere in vim-lsp, and avoids maintaining a large Vimscript dynamic
program.

### Locality scoring

Do not add a synchronous `textDocument/selectionRange` request to
`get_vim_completion_items()`. It would block the adapter path and would not
compose cleanly with asyncomplete's independently-issued completion request.

For the first implementation, use a server-independent approximation:

1. build a set of candidate words from effective `filterText`/`label`;
2. inspect at most 2,000 lines around the cursor;
3. tokenize each line once using the target buffer's `'iskeyword'`;
4. record the minimum absolute line distance for candidate words;
5. exclude the word span currently being completed;
6. give nearer occurrences a larger score;
7. assign no locality score to LSP kinds `Keyword` (14) and `Snippet` (15);
8. assign a neutral score when the buffer is unavailable or unloaded.

Do not scan the buffer once per candidate. One bounded pass over the buffer is
required for predictable performance.

This is deliberately not identical to Coc's selection-range scope depth, but
it captures the useful signal on every server and works through both native
omni and asyncomplete. Exact selection-range parity is a possible later
optimization after the simple version has been measured.

### Comparator

For `name: 'relevance'`, compare in this order:

1. fuzzy score, descending;
2. non-empty LSP `sortText`, ascending;
3. locality score, descending;
4. effective filter-text length, ascending;
5. original server index, ascending.

This mirrors the meaningful single-source portion of Coc's comparator.

Treat missing `sortText` explicitly:

- two missing values tie;
- an item with `sortText` should be compared by it only against another item
  with `sortText`;
- otherwise continue to locality and fallback fields.

Do not replace a missing `sortText` with `label` before reaching locality; the
legacy vim-lsp sorter currently does that, but it can suppress the locality
tie-breaker.

### Conversion integration

Refactor `lsp#omni#get_vim_completion_items()` into these conceptual steps:

1. unwrap and copy the raw result list;
2. determine the final minimum completion start character, including
   item-specific text-edit ranges;
3. derive the typed base from the current line and completion position;
4. run legacy `sortText` sorting or the relevance ranker according to config;
5. convert the ordered raw items into Vim completion items;
6. assign managed `user_data` in final display order;
7. perform the existing start-column correction.

Preserve all existing handling of:

- `textEdit`;
- insert/replace edits;
- `insertText`;
- snippets and placeholder stripping;
- `additionalTextEdits`;
- completion resolve;
- multibyte LSP/Vim position conversion;
- incomplete completion lists.

### Native fuzzy filter

Add `filter.name: 'fuzzy'` to `s:display_completions()` in
`autoload/lsp/omni.vim`.

The filter should:

- match against LSP `filterText` when present, otherwise the trimmed completion
  word;
- use `matchfuzzypos()` when available;
- preserve the incoming relevance order for equal fuzzy scores;
- fall back to the current prefix filter when fuzzy matching is unavailable.

Do not set `completeopt+=fuzzy` inside vim-lsp. That is editor-global policy and
can cause Vim to sort the list again after vim-lsp has combined fuzzy,
`sortText`, and locality signals.

## Explicit Non-Goals for the First Implementation

### MRU preselection

Do not implement MRU in the first slice.

Reasons:

- it did not affect the user's Coc configuration;
- it does not reorder Coc's list;
- Vim's `complete()` API cannot directly select an arbitrary row;
- moving the MRU item to index zero would change semantics;
- feeding repeated selection keys would be fragile.

If MRU is requested later, use an in-memory 100-entry LRU and capture accepted
items from `CompleteDonePre`/`CompleteDone`, but design its Vim UI behavior
separately.

### Exact selection-range locality

Do not add it in the first slice.

It would require:

- advertising `textDocument.selectionRange`;
- adding capability detection;
- issuing and cancelling a parallel request;
- coordinating it with native completion;
- adding an adapter hook to `asyncomplete-lsp.vim`;
- enforcing a strict timeout;
- handling stale cursor/buffer state.

The synchronous lexical locality index should be evaluated first.

### Cross-source ranking

Do not move asyncomplete source merging into vim-lsp. vim-lsp can rank one
server's items; asyncomplete remains responsible for LSP-versus-buffer source
priority.

## Implementation Sequence

### Checkpoint 1: Update and branch

From `/home/vinz/.vim/plugged/vim-lsp`:

```sh
git status --short --branch
git pull --ff-only
git rev-parse HEAD
git switch -c coc-style-completion-ranking
```

Confirm the checkout includes at least the supplied audit commit
`474c656659b5fb51eec6770309e0211c8aa49b5b`.

If upstream has materially changed `autoload/lsp/omni.vim`, re-run the source
trace before editing rather than forcing the old line-level design.

### Checkpoint 2: Add a pure ranker

Add `autoload/lsp/internal/completion/ranking.vim` and focused tests.

Keep this checkpoint independent of omnifunc integration. Test the ranker with
plain LSP item dictionaries and explicit context.

Commit after the focused tests pass.

### Checkpoint 3: Integrate conversion

Refactor `get_vim_completion_items()` to:

- copy instead of mutate the response list;
- compute the base and context;
- select legacy or relevance sorting;
- convert in final order.

Update existing sort tests without removing coverage of legacy behavior.

Commit after `test/lsp/omni.vimspec` passes.

### Checkpoint 4: Add native fuzzy filtering

Add `filter.name: 'fuzzy'`, tests, and documentation.

Commit after focused and full tests pass.

### Checkpoint 5: Verify asyncomplete behavior

Use the installed `asyncomplete-lsp.vim` adapter. Confirm it consumes the
ranked converter output and that its default `matchfuzzypos()` preprocessor
does not destroy equal-score ordering.

Do not modify another plugin in this checkpoint. If an adapter change proves
necessary, document the exact missing hook and stop before expanding scope.

### Checkpoint 6: Manual clangd comparison

Use a small C++ buffer containing:

- a local variable;
- a parameter;
- a member;
- a global with a similar prefix;
- candidates with camel-case names;
- candidates that differ only in `sortText`;
- more than the previous 200-item cutoff if clangd can produce them.

Record the first ten candidates for the same prefixes under:

1. Coc;
2. legacy vim-lsp sort;
3. vim-lsp relevance sort;
4. vim-lsp through asyncomplete.

The local/parameter/member candidates should improve without breaking clangd's
strong `sortText` preferences.

## Test Plan

Add:

```text
test/lsp/internal/completion/ranking.vimspec
```

At minimum cover:

- full match ahead of a scattered match;
- case-correct prefix ahead of a weaker match;
- camel-case/separator matching as provided by `matchfuzzypos()`;
- `filterText` used instead of `label`;
- `sortText` used after equal fuzzy scores;
- nearer buffer occurrence used after equal fuzzy and `sortText` values;
- keyword and snippet kinds receiving neutral locality;
- current incomplete word excluded from locality;
- missing `sortText` allowing locality to decide;
- shorter label fallback;
- stable original order for complete ties;
- empty base;
- multibyte labels and buffer text;
- unloaded/missing buffer fallback;
- result count above `max` preserving server order;
- no mutation of the input response list.

Extend `test/lsp/omni.vimspec` to cover:

- legacy `sort: {'max': ...}` unchanged;
- `sort.name: 'sortText'`;
- `sort.name: 'relevance'`;
- managed `user_data` still resolving to the correct original LSP item after
  ranking;
- snippet and text-edit start-column correction after ranking;
- list and `CompletionList` response shapes.

Add native filter tests for:

- fuzzy matches;
- `filterText`;
- fallback when `matchfuzzypos()` is unavailable or disabled;
- no accidental alphabetical re-sort of equal matches.

## Running Tests

vim-lsp uses `vim-themis`. It was not installed globally during this audit.

Follow the repository README/CI setup, then run focused tests first:

```sh
themis test/lsp/internal/completion/ranking.vimspec
themis test/lsp/omni.vimspec
```

Then run the complete suite:

```sh
themis
```

Also run vint or the repository's current lint command if upstream has added
one since the audit.

For performance, time the pure ranker with:

- 100 items;
- 1,000 items;
- 2,000 items;
- a 2,000-line locality window.

Use `reltime()` in a temporary/manual harness. Do not add a flaky wall-clock
assertion to the normal unit suite. Check that buffer tokenization occurs once
per ranking pass, not once per item.

## Manual Acceptance Criteria

The work is complete when all of the following are true:

- typed relevance visibly beats alphabetical ordering;
- LSP `filterText` and `sortText` are honored;
- an already-used nearby identifier wins locality ties over an unseen global;
- large clangd lists no longer fall back to arbitrary server order merely
  because they contain more than 200 items when `max` is configured higher;
- native omni and asyncomplete show compatible ordering;
- the old custom asyncomplete alphabetical preprocessor is not required;
- snippets, text edits, completion resolve, and additional edits still work;
- multibyte tests pass;
- the complete vim-lsp test suite passes;
- no Coc source code was copied;
- commits are split by the checkpoints above.

## Later Dotfiles Follow-Up

After the plugin implementation is proven, a separate dotfiles session can
switch from Coc back to vim-lsp/asyncomplete.

That later change should:

- enable `filter.name: 'fuzzy'`;
- enable `sort.name: 'relevance'`;
- choose a measured `sort.max` value, initially 2,000;
- enable locality;
- use asyncomplete's default fuzzy preprocessor or a replacement that preserves
  rank;
- assign LSP sources a higher source priority than the buffer source;
- keep the existing member-completion suppression for the buffer source if it
  is still useful;
- remove Coc only after an A/B comparison succeeds.

Do not combine that dotfiles migration with the vim-lsp implementation branch.

## Source Map for the Next Session

Coc:

```text
/tmp/coc.nvim/src/completion/complete.ts
  Complete.filterItems()
  sortItems()

/tmp/coc.nvim/src/completion/wordDistance.ts
  WordDistance.create()

/tmp/coc.nvim/src/completion/util.ts
  MruLoader
  Converter

/tmp/coc.nvim/src/completion/pum.ts
  Pum.show()

/tmp/coc.nvim/src/completion/index.ts
  Completion.addMruItem()
  Completion._onFinish()

/tmp/coc.nvim/src/util/filter.ts
  fuzzyScore()
  fuzzyScoreGracefulAggressive()

/tmp/coc.nvim/data/schema.json
  suggest.filterGraceful
  suggest.localityBonus
  suggest.noselect
  suggest.selection
```

vim-lsp:

```text
/home/vinz/.vim/plugged/vim-lsp/autoload/lsp/omni.vim
  lsp#omni#complete()
  s:display_completions()
  s:sort_by_sorttext()
  lsp#omni#get_vim_completion_items()

/home/vinz/.vim/plugged/vim-lsp/autoload/lsp/ui/vim/completion.vim
  s:on_complete_done()

/home/vinz/.vim/plugged/vim-lsp/test/lsp/omni.vimspec
/home/vinz/.vim/plugged/vim-lsp/doc/vim-lsp.txt
```

Integration:

```text
/home/vinz/.vim/plugged/asyncomplete-lsp.vim/plugin/asyncomplete-lsp.vim
  s:handle_completion()

/home/vinz/.vim/plugged/asyncomplete.vim/autoload/asyncomplete.vim
  s:default_preprocessor()
```
