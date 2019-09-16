"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-scripts/DoxygenToolkit.vim'
Plugin 'scrooloose/nerdtree'
Bundle 'taglist.vim'
Plugin 'Yggdroot/indentLine'
""Plugin 'rip-rip/clang_complete'
Plugin 'autocomplpop'
Plugin 'OmniCppComplete'
Plugin 'vim-scripts/echofunc.vim'
Plugin 'autoload_cscope.vim'
call vundle#end()            " required
filetype on
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""let g:clang_library_path='/usr/lib/llvm-6.0/lib'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DoxygenToolkit configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:DoxygenToolkit_authorName="guozhenkun@unisound.com"
let g:DoxygenToolkit_companyName="Unisound"
function GenLicense()
  let l:licenseTemplate = ""
  let l:licenseTemplate = l:licenseTemplate . "*************************************************************************\<enter>"
  let l:licenseTemplate = l:licenseTemplate . "Copyright (C) :YEAR:-:YEAR:  :COMPANY:\<enter>\<enter>"
  let l:licenseTemplate = l:licenseTemplate . "This program is free software; you can redistribute it and/or modify\<enter>"
  let l:licenseTemplate = l:licenseTemplate . "it under the terms of the GNU General Public License as published by\<enter>"
  let l:licenseTemplate = l:licenseTemplate . "the Free Software Foundation; either version 2 of the License, or\<enter>"
  let l:licenseTemplate = l:licenseTemplate . "any later version.\<enter>\<enter>"
  let l:licenseTemplate = l:licenseTemplate . "This program is distributed in the hope that it will be useful,\<enter>"
  let l:licenseTemplate = l:licenseTemplate . "but WITHOUT ANY WARRANTY; without even the implied warranty of\<enter>"
  let l:licenseTemplate = l:licenseTemplate . "MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\<enter>"
  let l:licenseTemplate = l:licenseTemplate . "GNU General Public License for more details.\<enter>\<enter>"
  let l:licenseTemplate = l:licenseTemplate . "You should have received a copy of the GNU General Public License along\<enter>"
  let l:licenseTemplate = l:licenseTemplate . "with this program; if not, write to the Free Software Foundation, Inc.\<enter>"
  let l:licenseTemplate = l:licenseTemplate . "51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.\<enter>"
  let l:licenseTemplate = l:licenseTemplate . "*************************************************************************\<enter>\<enter>"
  let l:licenseTemplate = l:licenseTemplate . " Description : :FILENAME:\<enter>"
  let l:licenseTemplate = l:licenseTemplate . " Author      : :AUTHOR:\<enter>"
  let l:licenseTemplate = l:licenseTemplate . " Date        : :DATESTART:\<enter>\<enter>"
  let l:licenseTemplate = l:licenseTemplate . "************************************************************************"
  let l:YEAR = strftime("%Y")
  let l:DATESTART = strftime("%Y.%m.%d")
  let l:FILENAME = expand('%:t')

  let l:licenseTemplate = substitute(l:licenseTemplate, ":YEAR:", l:YEAR, "g")
  let l:licenseTemplate = substitute(l:licenseTemplate, ":COMPANY:", g:DoxygenToolkit_companyName, "g")
  let l:licenseTemplate = substitute(l:licenseTemplate, ":FILENAME:", l:FILENAME, "g")
  let l:licenseTemplate = substitute(l:licenseTemplate, ":AUTHOR:", g:DoxygenToolkit_authorName, "g")
  let l:licenseTemplate = substitute(l:licenseTemplate, ":DATESTART:", l:DATESTART, "g")
  return l:licenseTemplate
endfunction
let g:DoxygenToolkit_licenseTag = GenLicense()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Function key maping
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F8> :NERDTreeToggle <CR>
inoremap <F8> :NERDTreeToggle <CR>
map <F7> :TlistToggle <CR>
inoremap <F7> <esc>:TlistToggle <CR>
inoremap jk <esc>
syntax on

set hlsearch
set autoindent
set cindent
set smartindent
set ruler
set showcmd
set shiftround
set mouse=a
set nu
set tabstop=2
set shiftwidth=2
set softtabstop=2
set backspace=indent,eol,start
if &ft != 'make'
  set expandtab
else
  set noexpandtab
endif

au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn


nmap <silent> <leader>v :exec '!exec google-chrome %'<CR>
set list
set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:.
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

set cc=120


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let Tlist_Exit_OnlyWindow=1
set tags+=/usr/include/tags
set tags+=~/.ctags/tags
let Tlist_Use_Right_Window=1
set completeopt=longest,menu
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=1
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    endif
    set csverb
endif

nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
map <C-K> :pyf /usr/share/clang/clang-format-6.0/clang-format.py<cr>
imap <C-K> <c-o>:pyf /usr/share/clang/clang-format-6.0/clang-format.py<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" taglist
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let Tlist_Show_One_File=1
"let Tlist_Process_File_Always=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" power status line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/.local/lib/python2.7/site-packages/powerline/bindings/vim
"
"" These lines setup the environment to show graphics and colors correctly.
set t_Co=256
"
let g:minBufExplForceSyntaxEnable = 1
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
set laststatus=2 " Always display the statusline in all windows
set guifont=Inconsolata\ for\ Powerline:h14
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set nocp
let g:EchoFuncKeyNext='n'
let g:EchoFuncKeyPrev='p'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" omnicppcomplete setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight Pmenu    guibg=darkgrey  guifg=black
highlight PmenuSel guibg=lightgrey guifg=black
let OmniCpp_SelectFirstItem = 1
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " 显示函数参数列表
let OmniCpp_MayCompleteDot = 1   " 输入 .  后自动补全
let OmniCpp_MayCompleteArrow = 1 " 输入 -> 后自动补全
let OmniCpp_MayCompleteScope = 1 " 输入 :: 后自动补全
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" 自动关闭补全窗口
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest
