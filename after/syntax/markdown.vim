syntax match todoCheckbox '\v(\s+)?(-|\*)(\s)?\[(\s)?\]'hs=e-4 conceal cchar=
syntax match todoCheckbox '\v(\s+)?(-|\*)(\s)?\[(X|x)\]'hs=e-4 conceal cchar=
syntax match todoCheckbox '\v(\s+)?(-|\*)(\s)?\[-\]'hs=e-4 conceal cchar=☒
syntax match todoCheckbox '\v(\s+)?(-|\*)(\s)?\[\.\]'hs=e-4 conceal cchar=⊡
syntax match todoCheckbox '\v(\s+)?(-|\*)(\s)?\[o\]'hs=e-4 conceal cchar=⬕

syntax region markdownWikiLink matchgroup=markdownLinkDelimiter start="\[\[" end="\]\]" contains=markdownUrl keepend oneline concealends
syntax region markdownLinkText matchgroup=markdownLinkTextDelimiter start="!\=\[\%(\%(\_[^][]\|\[\_[^][]*\]\)*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart concealends
syntax region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" contains=markdownUrl keepend contained conceal

hi def link todoCheckbox Conceal

echo "Hi hello how are you"
