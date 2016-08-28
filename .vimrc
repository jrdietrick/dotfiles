" .vimrc

set tabstop=4                                               " 4 spaces for tabs.
set ts=4
set expandtab

set shiftwidth=4                                            " 4 spaces when shifting

set hlsearch                                                " Highlight and jump when searching
set incsearch

set list listchars=tab:→\ ,trail:·                          " Show unwanted whitespace

" autocmd BufWritePre *.py,*.java,*.cpp,*.c :%s/\s\+$//e      " Trim unwanted whitespace on save

colors evening
hi Normal ctermbg=none
