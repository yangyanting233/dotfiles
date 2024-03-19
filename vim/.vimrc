vim9script
# author: Yanting Yang
# lastmod: 2024-03-18
# version: 0

# options
set expandtab
set number
set shiftwidth=4
set showcmd
set signcolumn=yes
set softtabstop=4
set tabstop=4

# status line
set laststatus=2    # always show status line
set statusline=%t   # tail of the file name
set statusline+=[%{&fileencoding},%{&fileformat},%{&filetype}]
set statusline+=%m  # modified flag
set statusline+=%r  # read only flag
set statusline+=%=  # separation between left and right aligned items
set statusline+=tabstop=%{&tabstop}\ [%l/%L\ %3p%%,\ %c/%{strlen(getline('.'))}/%{&columns}]

syntax on
filetype plugin indent on

# hight built-in group
highlight Normal cterm=None ctermfg=None ctermbg=black ctermul=None
highlight Visual cterm=reverse ctermfg=None ctermbg=None ctermul=None

highlight TrailingWhitespace ctermbg=red
call matchadd("TrailingWhitespace", '\s\+$')
# From 41.2 - Inside a single-quote string all the characters are as they are.
# From :match - {group} must exist at the moment this command is executed.
# \s        whitespace character: <Space> and <Tab>
# \+        1 or more   as many as possible
# $         end-of-line (at end of pattern) /zero-width
highlight Tab ctermbg=red
call matchadd("Tab", '\t')
# \t        matches <Tab>
highlight FinalNewlines ctermbg=red
call matchadd("FinalNewlines", '\n\+\%$')
# \%$       end of file /zero-width


def TrimTrailingWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
enddef
command! TrimTrailingWhitespace call TrimTrailingWhitespace()

def TrimFinalNewlines()
    let l:save = winsaveview()
    keeppatterns %s/\n\+\%$//e
    call winrestview(l:save)
enddef
command! TrimFinalNewlines call TrimFinalNewlines()

# Python
if executable('python')
    var LDLIBRARY = system("python -c 'import sysconfig; print(sysconfig.get_config_var(\"LDLIBRARY\"))'")
    exe 'set pythonthreedll=' .. LDLIBRARY
endif
