" syntax match todoCheckbox '\v(\s+)?(-|\*)(\s)?\[(\s)?\]' contains=todoCheckboxChecked conceal cchar=
" syntax match todoCheckboxChecked '\v(\s+)?(-|\*)(\s)?\[(X|x)\]' conceal cchar=
"
" syntax region markdownWikiLink matchgroup=markdownLinkDelimiter start="\[\[" end="\]\]" contains=markdownUrl keepend oneline concealends
" syntax region markdownLinkText matchgroup=markdownLinkTextDelimiter start="!\=\[\%(\%(\_[^][]\|\[\_[^][]*\]\)*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart concealends
" syntax region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" contains=markdownUrl keepend contained conceal
"
" hi def link todoCheckbox Conceal
"
"
"
" let s:checkbox_unchecked = "\u2611"
" let s:checkbox_checked = "\u2612"
" syntax match markdownCheckbox "^\s*\([-\*] \[[ x]\]\|--\|++\) " contains=markdownCheckboxChecked,markdownCheckboxUnchecked
" syntax match markdownCheckbox "" contains markdownCheckboxChecked,markdownCheckboxUnchecked
" execute 'syntax match markdownCheckboxUnchecked "\([-\*] \[ \]\|--\)" contained conceal cchar='.s:checkbox_unchecked
" execute 'syntax match markdownCheckboxChecked "\([-\*] \[x\]\|++\)" contained conceal cchar='.s:checkbox_checked
"
"
"
" syn match inProgress "\[ ] .\+" contains=inProgressMark
" syn match inProgressMark "\[ ]" conceal cchar=☐
" syn match itemComplete "\[x] .\+" contains=itemCompleteMark
" syn match itemCompleteMark "\[x]" conceal cchar=✔
