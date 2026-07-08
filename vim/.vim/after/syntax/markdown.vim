" Keep underscores as italic, but render single-star emphasis as bold.
if !exists('b:current_syntax')
  finish
endif

if b:current_syntax ==# 'mkd'
  let s:oneline = get(g:, 'vim_markdown_emphasis_multiline', 1) ? '' : ' oneline'
  let s:concealends = has('conceal') && get(g:, 'vim_markdown_conceal', 1) ? ' concealends' : ''

  syntax clear htmlItalic
  syntax clear htmlBold

  if !exists('html_no_rendering')
    syntax region htmlBold start="<b\>" end="</b\_s*>"me=s-1 contains=@htmlTop,htmlBoldUnderline,htmlBoldItalic
    syntax region htmlBold start="<strong\>" end="</strong\_s*>"me=s-1 contains=@htmlTop,htmlBoldUnderline,htmlBoldItalic
    syntax region htmlItalic start="<i\>" end="</i\_s*>"me=s-1 contains=@htmlTop,htmlItalicBold,htmlItalicUnderline
    syntax region htmlItalic start="<em\>" end="</em\_s*>"me=s-1 contains=@htmlTop
  endif

  execute 'syntax region htmlItalic matchgroup=mkdItalic start="\%(^\|\s\)\zs_\ze[^\\_\t ]" end="[^\\_\t ]\zs_\ze\_W" keepend contains=@Spell' . s:oneline . s:concealends
  execute 'syntax region htmlBold matchgroup=mkdBold start="\%(^\|\s\)\zs\*\ze[^\\\*\t ]\%(\%([^*]\|\\\*\|\n\)*[^\\\*\t ]\)\?\*\_W" end="[^\\\*\t ]\zs\*\ze\_W" keepend contains=@Spell' . s:oneline . s:concealends
  execute 'syntax region htmlBold matchgroup=mkdBold start="\%(^\|\s\)\zs\*\*\ze\S" end="\S\zs\*\*" keepend contains=@Spell' . s:oneline . s:concealends
  execute 'syntax region htmlBold matchgroup=mkdBold start="\%(^\|\s\)\zs__\ze\S" end="\S\zs__" keepend contains=@Spell' . s:oneline . s:concealends

  unlet s:oneline
  unlet s:concealends
elseif b:current_syntax ==# 'markdown'
  let s:concealends = has('conceal') && get(g:, 'markdown_syntax_conceal', 1) ? ' concealends' : ''

  syntax clear markdownItalic
  syntax clear markdownBold

  execute 'syn region markdownItalic matchgroup=markdownItalicDelimiter start="\w\@<!_\S\@=" end="\S\@<=_\w\@!\|^$" skip="\\_" contains=markdownLineStart,@Spell' . s:concealends
  execute 'syn region markdownBold matchgroup=markdownBoldDelimiter start="\*\S\@=" end="\S\@<=\*\|^$" skip="\\\*" contains=markdownLineStart,@Spell' . s:concealends
  execute 'syn region markdownBold matchgroup=markdownBoldDelimiter start="\*\*\S\@=" end="\S\@<=\*\*\|^$" skip="\\\*" contains=markdownLineStart,markdownItalic,@Spell' . s:concealends
  execute 'syn region markdownBold matchgroup=markdownBoldDelimiter start="\w\@<!__\S\@=" end="\S\@<=__\w\@!\|^$" skip="\\_" contains=markdownLineStart,markdownItalic,@Spell' . s:concealends

  unlet s:concealends
endif
