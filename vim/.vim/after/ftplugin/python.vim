vim9script
# Python Filetype Plugin Written by Yanting at 2024-03-18.

if ! executable('ruff')
    finish
endif

setlocal makeprg=ruff\ check\ %:p
setlocal errorformat=%f:%l:%c:\ %m,%-G%.%#

def RuffCheck()
    silent make!
    redraw!
    call sign_define('QuickFixError', {'text': '>>', 'texthl': 'NONE', 'linehl': 'NONE'})
    call sign_unplace('*', {'buffer': bufnr()})
    var qfl = getqflist()
    for item in qfl
        call sign_place(0, 'Error', 'QuickFixError', item.bufnr, {'lnum': item.lnum})
    endfor
enddef
command! RuffCheck call RuffCheck()
