"- configuration ---------------------------------------------------------------

if ! exists('g:RelativeNumberCurrentWindow_SameNumberWidth')
    let g:RelativeNumberCurrentWindow_SameNumberWidth = 1
endif
if ! exists('g:RelativeNumberCurrentWindow_OnFocus')
    let g:RelativeNumberCurrentWindow_OnFocus = 1
endif
if ! exists('g:RelativeNumberCurrentWindow_OnInsert')
    let g:RelativeNumberCurrentWindow_OnInsert = 1
endif



"- functions -------------------------------------------------------------------

function! s:LocalNumber()
    return (&l:relativenumber ? 2 : (&l:number ? 1 : 0))
endfunction

if v:version == 703 && has('patch861') || v:version > 703
function! s:RelativeNumberOnEnter()
"****D echomsg '****' bufnr('').'/'.winnr() s:LocalNumber() exists('w:relativenumber')
    if exists('w:relativenumber') && s:LocalNumber() == 1
	setlocal relativenumber
	let &l:number = w:relativenumber
    endif
endfunction
function! s:RelativeNumberOnLeave()
    if s:LocalNumber() == 2
	let w:relativenumber = &l:number    " Store the 'number' option that configures how the current relative line is displayed (:help number_relativenumber).
	setlocal norelativenumber number
    else
	unlet! w:relativenumber
    endif
endfunction
else
function! s:RelativeNumberOnEnter()
"****D echomsg '****' bufnr('').'/'.winnr() s:LocalNumber() exists('w:relativenumber')
    if exists('w:relativenumber') && s:LocalNumber() == 1
	setlocal relativenumber
    endif
endfunction

function! s:RelativeNumberOnLeave()
    if s:LocalNumber() == 2
	" XXX: Switching locally to 'number' also resets the global
	" 'relativenumber'; we don't want this; on some :edits (especially
	" through my :EditNext), the line numbering is completely lost due to
	" this.
	let l:global_relativenumber = &g:relativenumber
	    setlocal number
	let &g:relativenumber = l:global_relativenumber
	let w:relativenumber = 1
    else
	unlet! w:relativenumber
    endif
endfunction
endif

function! s:AdaptNumberwidth()
    let &l:numberwidth = max([len(string(&lines)), len(string(line('$')))]) + 1
endfunction



"- autocmds --------------------------------------------------------------------

let s:onEnterEvents = 'VimEnter,WinEnter,BufWinEnter'
let s:onLeaveEvents = 'WinLeave'
if g:RelativeNumberCurrentWindow_OnFocus
    let s:onEnterEvents .= ',FocusGained'
    let s:onLeaveEvents .= ',FocusLost'
endif
if g:RelativeNumberCurrentWindow_OnInsert
    let s:onEnterEvents .= ',InsertLeave'
    let s:onLeaveEvents .= ',InsertEnter'
endif

augroup RelativeNumber
    autocmd!
    execute 'autocmd' s:onEnterEvents '* call <SID>RelativeNumberOnEnter()'
    execute 'autocmd' s:onLeaveEvents '* call <SID>RelativeNumberOnLeave()'

    if g:RelativeNumberCurrentWindow_SameNumberWidth
	" For 'relativenumber', take the maximum possible number of 'lines', not
	" the actual 'winheight', so that (frequently occurring) window
	" resizings do not cause width changes, neither.
	execute 'autocmd' s:onEnterEvents '* call <SID>AdaptNumberwidth()'
    endif
augroup END

unlet s:onEnterEvents s:onLeaveEvents
