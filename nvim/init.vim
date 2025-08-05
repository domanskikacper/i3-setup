" === Podstawowe ustawienia ===
set number              " Pokazuje numer linii
set tabstop=4           " Tab = 4 spacje
set shiftwidth=4        " Wcięcie = 4 spacje
set smartindent         " Automatyczne wcięcia
set nowrap              " Nie zawija długich linii
set mouse=a             " Włącz obsługę myszy
set clipboard=unnamedplus " Umożliwia kopiowanie do systemowego schowka

" === Kolorowanie ===
syntax on               " Włącza kolorowanie składni
set termguicolors       " Lepsze kolory w terminalu

" === Pluginy (z Vim-Plugiem) ===
call plug#begin('~/.vim/plugged')

Plug 'vim-syntastic/syntastic' " Linter
Plug 'vim-airline/vim-airline' " Pasek statusu
Plug 'preservim/nerdtree'      " File explorer
Plug 'windwp/nvim-autopairs'

call plug#end()

lua << EOF
require('nvim-autopairs').setup{}
EOF

" === Skróty klawiszowe ===
nnoremap <C-n> :NERDTreeToggle<CR>
