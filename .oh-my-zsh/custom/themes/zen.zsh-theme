PROMPT=$'
%{$fg_bold[black]%}%T%{$reset_color%} %{$fg[blue]%}%c%{$reset_color%} $(git_prompt_info)
%{$fg_bold[black]%}>%{$reset_color%} '

PROMPT2="%{$fg_blod[black]%}%_> %{$reset_color%}"

GIT_CB=""
ZSH_THEME_SCM_PROMPT_PREFIX="%{$fg[cyan]%}("
ZSH_THEME_GIT_PROMPT_PREFIX=$ZSH_THEME_SCM_PROMPT_PREFIX$GIT_CB
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
