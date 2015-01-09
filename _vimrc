" =============================================================================
"        << �жϲ���ϵͳ�� Windows ���� Linux ���ж����ն˻��� Gvim >>
" =============================================================================
 
" -----------------------------------------------------------------------------
"  < �жϲ���ϵͳ�Ƿ��� Windows ���� Linux >
" -----------------------------------------------------------------------------
let g:iswindows = 0
let g:islinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif
 
" -----------------------------------------------------------------------------
"  < �ж����ն˻��� Gvim >
" -----------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif
 
 
" =============================================================================
"                          << ����Ϊ���Ĭ������ >>
" =============================================================================
 
" -----------------------------------------------------------------------------
"  < Windows Gvim Ĭ������> ����һ���޸�
" -----------------------------------------------------------------------------
if (g:iswindows && g:isGUI)
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
    set diffexpr=MyDiff()
 
    function MyDiff()
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
            if &sh =~ '\<cmd'
                let cmd = '""' . $VIMRUNTIME . '\diff"'
                let eq = '"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif
 
" -----------------------------------------------------------------------------
"  < Linux Gvim/Vim Ĭ������> ����һ���޸�
" -----------------------------------------------------------------------------
if g:islinux
    set hlsearch        "��������
    set incsearch       "������Ҫ����������ʱ��ʵʱƥ��
 
    " Uncomment the following to have Vim jump to the last position when
    " reopening a file
    if has("autocmd")
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    endif
 
    if g:isGUI
        " Source a global configuration file if available
        if filereadable("/etc/vim/gvimrc.local")
            source /etc/vim/gvimrc.local
        endif
    else
        " This line should not be removed as it ensures that various options are
        " properly set to work with the Vim-related packages available in Debian.
        runtime! debian.vim
 
        " Vim5 and later versions support syntax highlighting. Uncommenting the next
        " line enables syntax highlighting by default.
        if has("syntax")
            syntax on
        endif
 
        set mouse=a                    " ���κ�ģʽ���������
        set t_Co=256                   " ���ն�����256ɫ
        set backspace=2                " �����˸������
 
        " Source a global configuration file if available
        if filereadable("/etc/vim/vimrc.local")
            source /etc/vim/vimrc.local
        endif
    endif
endif
 
 
" =============================================================================
"                          << ����Ϊ�û��Զ������� >>
" =============================================================================
 
" -----------------------------------------------------------------------------
"  < Vundle ������������� >
" -----------------------------------------------------------------------------
" ���ڸ�����Ĺ���vim����������÷��ο� :h vundle ����
" Vundle���߰�װ����Ϊ���ն�������������
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" ������� windows ��װ�ͱ����Ȱ�װ "git for window"���ɲ�����������

set wildmenu                                          " vim ����������ģʽ���ܲ�ȫ
set nocompatible                                      "���� Vi ����ģʽ
filetype off                                          "�����ļ��������
 
if g:islinux
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
else
    set rtp+=$VIM/vimfiles/bundle/vundle/
    call vundle#rc('$VIM/vimfiles/bundle/')
endif
 
" ʹ��Vundle�����������������Ҫ�С�
Bundle 'gmarik/vundle'
 
" ����ΪҪ��װ����µĲ������ͬ�ֿⶼ�У�������д�淶��ο�������
Bundle 'a.vim'
Bundle 'Align'
Bundle 'jiangmiao/auto-pairs'
Bundle 'bufexplorer.zip'
Bundle 'ccvext.vim'
Bundle 'cSyntaxAfter'
Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'mattn/emmet-vim'
"Bundle 'vim-javacompleteex'
Bundle 'Mark--Karkat'
Bundle 'Shougo/neocomplcache.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'OmniCppComplete'
Bundle 'Lokaltog/vim-powerline'
Bundle 'repeat.vim'
Bundle 'msanders/snipmate.vim'
Bundle 'wesleyche/SrcExpl'
Bundle 'std_c.zip'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/syntastic'
Bundle 'majutsushi/tagbar'
Bundle 'taglist.vim'
Bundle 'TxtBrowser'
Bundle 'ZoomWin'
Bundle 'VimClojure'
 
" -----------------------------------------------------------------------------
"  < �������� >
" -----------------------------------------------------------------------------
" ע��ʹ��utf-8��ʽ����������Դ�롢�ļ�·�����������ģ����򱨴�
set encoding=utf-8                                    "����gvim�ڲ����룬Ĭ�ϲ�����
set fileencoding=utf-8                                "���õ�ǰ�ļ����룬���Ը��ģ��磺gbk��ͬcp936��
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1     "����֧�ִ򿪵��ļ��ı���
 
" �ļ���ʽ��Ĭ�� ffs=dos,unix
set fileformat=unix                                   "�����£���ǰ���ļ���<EOL>��ʽ�����Ը��ģ��磺dos��windowsϵͳ���ã�
set fileformats=unix,dos,mac                          "�����ļ���<EOL>��ʽ����
 
if (g:iswindows && g:isGUI)
    "����˵�����
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
 
    "���consle�������
    language messages zh_CN.utf-8
endif
 
" -----------------------------------------------------------------------------
"  < ��д�ļ�ʱ������ >
" -----------------------------------------------------------------------------
filetype on                                           "�����ļ��������
filetype plugin on                                    "��Բ�ͬ���ļ����ͼ��ض�Ӧ�Ĳ��
filetype plugin indent on                             "��������
set smartindent                                       "�������ܶ��뷽ʽ
set expandtab                                         "��Tab��ת��Ϊ�ո�
set tabstop=4                                         "����Tab���Ŀ�ȣ����Ը��ģ��磺���Ϊ2
set shiftwidth=4                                      "����ʱ�Զ�������ȣ��ɸ��ģ����ͬtabstop��
set smarttab                                          "ָ����һ��backspace��ɾ��shiftwidth���
set foldenable                                        "�����۵�
set foldmethod=indent                                 "indent �۵���ʽ
" set foldmethod=marker                                "marker �۵���ʽ
 
" ����ģʽ���ÿո�������ع���������۵���ע��zR չ�������۵���zM �ر������۵���
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
 
" ���ļ����ⲿ���޸ģ��Զ����¸��ļ�
set autoread
 
" ����ģʽ������ cS �����β�ո�
nmap cS :%s/\s\+$//g<CR>:noh<CR>
 
" ����ģʽ������ cM �����β ^M ����
nmap cM :%s/\r$//g<CR>:noh<CR>
 
set ignorecase                                        "����ģʽ����Դ�Сд
set smartcase                                         "�������ģʽ������д�ַ�����ʹ�� 'ignorecase' ѡ�ֻ������������ģʽ���Ҵ� 'ignorecase' ѡ��ʱ�Ż�ʹ��
" set noincsearch                                       "������Ҫ����������ʱ��ȡ��ʵʱƥ��
 
" Ctrl + K ����ģʽ�¹�������ƶ�
imap <c-k> <Up>
 
" Ctrl + J ����ģʽ�¹�������ƶ�
imap <c-j> <Down>
 
" Ctrl + H ����ģʽ�¹�������ƶ�
imap <c-h> <Left>
 
" Ctrl + L ����ģʽ�¹�������ƶ�
imap <c-l> <Right>
 
" ����ÿ�г���80�е��ַ���ʾ��������������»��ߣ��������þ�ע�͵�
"au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)
 
" -----------------------------------------------------------------------------
"  < �������� >
" -----------------------------------------------------------------------------
set number                                            "��ʾ�к�
set laststatus=2                                      "����״̬����Ϣ
set cmdheight=2                                       "���������еĸ߶�Ϊ2��Ĭ��Ϊ1
set cursorline                                        "ͻ����ʾ��ǰ��
if g:iswindows
    set fenc=gbk
    set guifont=Consolas:h10:cANSI                 "��������:�ֺţ��������ƿո����»��ߴ���
    set gfw=��Բ:h10:cGB2312                       "��������
endif
if g:islinux
    set guifont=Monospace\ 10                 "��������\ �ֺţ��������ƿո����»��ߴ��棩
endif
set nowrap                                            "���ò��Զ�����
set shortmess=atI                                     "ȥ����ӭ����
 
" ���� gVim ���ڳ�ʼλ�ü���С
if g:isGUI
    " au GUIEnter * simalt ~x                           "��������ʱ�Զ����
    winpos 100 10                                     "ָ�����ڳ��ֵ�λ�ã�����ԭ������Ļ���Ͻ�
    set lines=38 columns=120                          "ָ�����ڴ�С��linesΪ�߶ȣ�columnsΪ���
endif
 
" ���ô�����ɫ����
if g:isGUI
    colorscheme solarized              "Gvim��ɫ����
else
    colorscheme solarized              "�ն���ɫ����
endif
 
" ��ʾ/���ز˵������������������������� Ctrl + F11 �л�
if g:isGUI
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    nmap <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
        \set guioptions-=m <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=r <Bar>
        \set guioptions-=L <Bar>
    \else <Bar>
        \set guioptions+=m <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=r <Bar>
        \set guioptions+=L <Bar>
    \endif<CR>
endif
 
" -----------------------------------------------------------------------------
"  < ���롢���ӡ��������� (Ŀǰֻ������C��C++��Java����)>
" -----------------------------------------------------------------------------
" F9 һ�����桢���롢���Ӵ沢����
nmap <F9> :call Run()<CR>
imap <F9> <ESC>:call Run()<CR>
 
" Ctrl + F9 һ�����沢����
nmap <c-F9> :call Compile()<CR>
imap <c-F9> <ESC>:call Compile()<CR>
 
" Ctrl + F10 һ�����沢����
nmap <c-F10> :call Link()<CR>
imap <c-F10> <ESC>:call Link()<CR>
 
let s:LastShellReturn_C = 0
let s:LastShellReturn_L = 0
let s:ShowWarning = 1
let s:Obj_Extension = '.o'
let s:Exe_Extension = '.exe'
let s:Class_Extension = '.class'
let s:Sou_Error = 0
 
let s:windows_CFlags = 'gcc\ -fexec-charset=gbk\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
let s:linux_CFlags = 'gcc\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
 
let s:windows_CPPFlags = 'g++\ -fexec-charset=gbk\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
let s:linux_CPPFlags = 'g++\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
 
let s:JavaFlags = 'javac\ %'

let java_highlight_all=1
let java_highlight_functions="style"
 
func! Compile()
    exe ":ccl"
    exe ":update"
    let s:Sou_Error = 0
    let s:LastShellReturn_C = 0
    let Sou = expand("%:p")
    let v:statusmsg = ''
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
        let Obj = expand("%:p:r").s:Obj_Extension
        let Obj_Name = expand("%:p:t:r").s:Obj_Extension
        if !filereadable(Obj) || (filereadable(Obj) && (getftime(Obj) < getftime(Sou)))
            redraw!
            if expand("%:e") == "c"
                if g:iswindows
                    exe ":setlocal makeprg=".s:windows_CFlags
                else
                    exe ":setlocal makeprg=".s:linux_CFlags
                endif
                echohl WarningMsg | echo " compiling..."
                silent make
            elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
                if g:iswindows
                    exe ":setlocal makeprg=".s:windows_CPPFlags
                else
                    exe ":setlocal makeprg=".s:linux_CPPFlags
                endif
                echohl WarningMsg | echo " compiling..."
                silent make
            endif
            redraw!
            if v:shell_error != 0
                let s:LastShellReturn_C = v:shell_error
            endif
            if g:iswindows
                if s:LastShellReturn_C != 0
                    exe ":bo cope"
                    echohl WarningMsg | echo " compilation failed"
                else
                    if s:ShowWarning
                        exe ":bo cw"
                    endif
                    echohl WarningMsg | echo " compilation successful"
                endif
            else
                if empty(v:statusmsg)
                    echohl WarningMsg | echo " compilation successful"
                else
                    exe ":bo cope"
                endif
            endif
        else
            echohl WarningMsg | echo ""Obj_Name"is up to date"
        endif
    elseif expand("%:e") == "java"
        let class = expand("%:p:r").s:Class_Extension
        let class_Name = expand("%:p:t:r").s:Class_Extension
        if !filereadable(class) || (filereadable(class) && (getftime(class) < getftime(Sou)))
            redraw!
            exe ":setlocal makeprg=".s:JavaFlags
            echohl WarningMsg | echo " compiling..."
            silent make
            redraw!
            if v:shell_error != 0
                let s:LastShellReturn_C = v:shell_error
            endif
            if g:iswindows
                if s:LastShellReturn_C != 0
                    exe ":bo cope"
                    echohl WarningMsg | echo " compilation failed"
                else
                    if s:ShowWarning
                        exe ":bo cw"
                    endif
                    echohl WarningMsg | echo " compilation successful"
                endif
            else
                if empty(v:statusmsg)
                    echohl WarningMsg | echo " compilation successful"
                else
                    exe ":bo cope"
                endif
            endif
        else
            echohl WarningMsg | echo ""class_Name"is up to date"
        endif
    else
        let s:Sou_Error = 1
        echohl WarningMsg | echo " please choose the correct source file"
    endif
    exe ":setlocal makeprg=make"
endfunc
 
func! Link()
    call Compile()
    if s:Sou_Error || s:LastShellReturn_C != 0
        return
    endif
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
        let s:LastShellReturn_L = 0
        let Sou = expand("%:p")
        let Obj = expand("%:p:r").s:Obj_Extension
        if g:iswindows
            let Exe = expand("%:p:r").s:Exe_Extension
            let Exe_Name = expand("%:p:t:r").s:Exe_Extension
        else
            let Exe = expand("%:p:r")
            let Exe_Name = expand("%:p:t:r")
        endif
        let v:statusmsg = ''
        if filereadable(Obj) && (getftime(Obj) >= getftime(Sou))
            redraw!
            if !executable(Exe) || (executable(Exe) && getftime(Exe) < getftime(Obj))
                if expand("%:e") == "c"
                    setlocal makeprg=gcc\ -o\ %<\ %<.o
                    echohl WarningMsg | echo " linking..."
                    silent make
                elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
                    setlocal makeprg=g++\ -o\ %<\ %<.o
                    echohl WarningMsg | echo " linking..."
                    silent make
                endif
                redraw!
                if v:shell_error != 0
                    let s:LastShellReturn_L = v:shell_error
                endif
                if g:iswindows
                    if s:LastShellReturn_L != 0
                        exe ":bo cope"
                        echohl WarningMsg | echo " linking failed"
                    else
                        if s:ShowWarning
                            exe ":bo cw"
                        endif
                        echohl WarningMsg | echo " linking successful"
                    endif
                else
                    if empty(v:statusmsg)
                        echohl WarningMsg | echo " linking successful"
                    else
                        exe ":bo cope"
                    endif
                endif
            else
                echohl WarningMsg | echo ""Exe_Name"is up to date"
            endif
        endif
        setlocal makeprg=make
    elseif expand("%:e") == "java"
        return
    endif
endfunc
 
func! Run()
    let s:ShowWarning = 0
    call Link()
    let s:ShowWarning = 1
    if s:Sou_Error || s:LastShellReturn_C != 0 || s:LastShellReturn_L != 0
        return
    endif
    let Sou = expand("%:p")
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
        let Obj = expand("%:p:r").s:Obj_Extension
        if g:iswindows
            let Exe = expand("%:p:r").s:Exe_Extension
        else
            let Exe = expand("%:p:r")
        endif
        if executable(Exe) && getftime(Exe) >= getftime(Obj) && getftime(Obj) >= getftime(Sou)
            redraw!
            echohl WarningMsg | echo " running..."
            if g:iswindows
                exe ":!%<.exe"
            else
                if g:isGUI
                    exe ":!gnome-terminal -x bash -c './%<; echo; echo �밴 Enter ������; read'"
                else
                    exe ":!clear; ./%<"
                endif
            endif
            redraw!
            echohl WarningMsg | echo " running finish"
        endif
    elseif expand("%:e") == "java"
        let class = expand("%:p:r").s:Class_Extension
        if getftime(class) >= getftime(Sou)
            redraw!
            echohl WarningMsg | echo " running..."
            if g:iswindows
                exe ":!java %<"
            else
                if g:isGUI
                    exe ":!gnome-terminal -x bash -c 'java %<; echo; echo �밴 Enter ������; read'"
                else
                    exe ":!clear; java %<"
                endif
            endif
            redraw!
            echohl WarningMsg | echo " running finish"
        endif
    endif
endfunc
 
 
" -----------------------------------------------------------------------------
"  < ���������Ԥ�� Html �� PHP �ļ� >
" -----------------------------------------------------------------------------
" �޸�ǰ����ͨ����ģ�飬�������ٸ��Ա������
 
" F5 �������������д���������Ԥ��������ǰ��ȷ���а�װ��Ӧ�������������������ú��䰲װĿ¼
if g:iswindows
    "����Ϊֻ֧��Windowsϵͳ�������
 
    " ����ϵͳIE�����Ԥ���������ж�ؿɽ���ע��
    nmap <F5>ie :call ViewInBrowser("ie")<cr>
    imap <F5>ie <ESC>:call ViewInBrowser("ie")<cr>
 
    " ����IETester(IE���Թ���)Ԥ��������а�װ��ȡ��ע��
    " nmap <F5>ie6 :call ViewInBrowser("ie6")<cr>
    " imap <F5>ie6 <ESC>:call ViewInBrowser("ie6")<cr>
    " nmap <F5>ie7 :call ViewInBrowser("ie7")<cr>
    " imap <F5>ie7 <ESC>:call ViewInBrowser("ie7")<cr>
    " nmap <F5>ie8 :call ViewInBrowser("ie8")<cr>
    " imap <F5>ie8 <ESC>:call ViewInBrowser("ie8")<cr>
    " nmap <F5>ie9 :call ViewInBrowser("ie9")<cr>
    " imap <F5>ie9 <ESC>:call ViewInBrowser("ie9")<cr>
    " nmap <F5>ie10 :call ViewInBrowser("ie10")<cr>
    " imap <F5>ie10 <ESC>:call ViewInBrowser("ie10")<cr>
    " nmap <F5>iea :call ViewInBrowser("iea")<cr>
    " imap <F5>iea <ESC>:call ViewInBrowser("iea")<cr>
elseif g:islinux
    "����Ϊֻ֧��Linuxϵͳ�������
    "��δ���ã�����ʱ����Ū��
endif
 
"����Ϊ֧��Windows��Linuxϵͳ�������
 
" ����Firefox�����Ԥ��������а�װ��ȡ��ע��
" nmap <F5>ff :call ViewInBrowser("ff")<cr>
" imap <F5>ff <ESC>:call ViewInBrowser("ff")<cr>
 
" ����Maxthon(����)�����Ԥ��������а�װ��ȡ��ע��
" nmap <F5>ay :call ViewInBrowser("ay")<cr>
" imap <F5>ay <ESC>:call ViewInBrowser("ay")<cr>
 
" ����Opera�����Ԥ��������а�װ��ȡ��ע��
" nmap <F5>op :call ViewInBrowser("op")<cr>
" imap <F5>op <ESC>:call ViewInBrowser("op")<cr>
 
" ����Chrome�����Ԥ��������а�װ��ȡ��ע��
" nmap <F5>cr :call ViewInBrowser("cr")<cr>
" imap <F5>cr <ESC>:call ViewInBrowser("cr")<cr>
 
" ��������ú���
function! ViewInBrowser(name)
    if expand("%:e") == "php" || expand("%:e") == "html"
        exe ":update"
        if g:iswindows
            "��ȡҪԤ�����ļ�·��������·���е�'\'�滻Ϊ'/'��ͬʱ��·�����ֵı���ת��Ϊgbk��ͬcp936��
            let file = iconv(substitute(expand("%:p"), '\', '/', "g"), "utf-8", "gbk")
 
            "�����·�����ã�·����ʹ��'/'б�ܣ�����·�������˫�����������
            "����ֻ������ϵͳIE��������������������Ŀɽ���ȡ��ע�ͣ����Ȱ�װ�������úð�װ·������Ҳ�ɰ�������
            let SystemIE = "C:/progra~1/intern~1/iexplore.exe"  "ϵͳ�Դ�IEĿ¼
            " let IETester = "F:/IETester/IETester.exe"           "IETester����Ŀ¼���ɰ�ʵ�ʸ��ģ�
            " let Chrome = "F:/Chrome/Chrome.exe"                 "Chrome����Ŀ¼���ɰ�ʵ�ʸ��ģ�
            " let Firefox = "F:/Firefox/Firefox.exe"              "Firefox����Ŀ¼���ɰ�ʵ�ʸ��ģ�
            " let Opera = "F:/Opera/opera.exe"                    "Opera����Ŀ¼���ɰ�ʵ�ʸ��ģ�
            " let Maxthon = "C:/Progra~2/Maxthon/Bin/Maxthon.exe" "Maxthon����Ŀ¼���ɰ�ʵ�ʸ��ģ�
 
            "����������������ã��Ҳ��Ե���phpStudy2014���ɸ����Լ����޸ģ�����·�������˫�����������
            let htdocs ="F:/phpStudy2014/WWW/"                  "�����������ַ��Ŀ¼���ɰ�ʵ�ʸ��ģ�
            let url = "localhost"                               "�����������ַ���ɰ�ʵ�ʸ��ģ�
        elseif g:islinux
            "��ʱ��û�����ã���ʱ����Ū�ˡ�
        endif
 
        "�����������д���ɸ���ʵ��������ע�⣬���������·����û�ж�����ı������Ⱥ��ұ�Ϊ���������ܳ���������Ӵ���ɽ���ע�ͻ�ɾ����
        let l:browsers = {}                             "������д�ֵ���������в���ɾ����ע��
        " let l:browsers["cr"] = Chrome                   "Chrome�������д
        " let l:browsers["ff"] = Firefox                  "Firefox�������д
        " let l:browsers["op"] = Opera                    "Opera�������д
        " let l:browsers["ay"] = Maxthon                  "�����������д
        let l:browsers["ie"] = SystemIE                 "ϵͳIE�������д
        " let l:browsers["ie6"] = IETester."-ie6"         "����IETESTER������IE6Ԥ����д�������Ӳ�����
        " let l:browsers["ie7"] = IETester."-ie7"         "����IETESTER������IE7Ԥ����д�������Ӳ�����
        " let l:browsers["ie8"] = IETester."-ie8"         "����IETESTER������IE8Ԥ����д�������Ӳ�����
        " let l:browsers["ie9"] = IETester."-ie9"         "����IETESTER������IE9Ԥ����д�������Ӳ�����
        " let l:browsers["ie10"] = IETester."-ie10"       "����IETESTER������IE10Ԥ����д�������Ӳ�����
        " let l:browsers["iea"] = IETester."-al"          "����IETESTER������֧�ֵ�����IE�汾Ԥ����д�������Ӳ�����
 
        if stridx(file, htdocs) == -1   "�ļ����ڱ������������Ŀ¼����ֱ��Ԥ���������ܽ���PHP�ļ���
           exec ":silent !start ". l:browsers[a:name] ." file://" . file
        else    "�ļ��ڱ������������Ŀ¼������ñ����������������Ԥ�������������������������
            let file = substitute(file, htdocs, "http://".url."/", "g")    "ת���ļ�·��Ϊ�����������ַ·��
            exec ":silent !start ". l:browsers[a:name] file
        endif
    else
        echohl WarningMsg | echo " please choose the correct source file"
    endif
endfunction
 
" -----------------------------------------------------------------------------
"  < �������� >
" -----------------------------------------------------------------------------
set writebackup                             "�����ļ�ǰ�������ݣ�����ɹ���ɾ���ñ���
set nobackup                                "�����ޱ����ļ�
" set noswapfile                              "��������ʱ�ļ�
" set vb t_vb=                                "�ر���ʾ��
 
 
" =============================================================================
"                          << ����Ϊ���ò������ >>
" =============================================================================
 
" -----------------------------------------------------------------------------
"  < a.vim ������� >
" -----------------------------------------------------------------------------
" �����л�C/C++ͷ�ļ�
" :A     ---�л�ͷ�ļ�����ռ��������
" :AV    ---�л�ͷ�ļ�����ֱ�ָ��
" :AS    ---�л�ͷ�ļ���ˮƽ�ָ��
 
" -----------------------------------------------------------------------------
"  < Align ������� >
" -----------------------------------------------------------------------------
" һ������Ĳ�������������Ű��������룬����ǿ�󣬲����õ��Ļ��᲻��
 
" -----------------------------------------------------------------------------
"  < auto-pairs ������� >
" -----------------------------------------------------------------------------
" ���������������Զ���ȫ���������뺯��ԭ����ʾ���echofunc��ͻ
" �����Ҿ�û�м���echofunc���
 
" -----------------------------------------------------------------------------
"  < BufExplorer ������� >
" -----------------------------------------------------------------------------
" �������ɵ��ڻ������л����൱����һ�ֶ���ļ�����л���ʽ��
" <Leader>be �ڵ�ǰ������ʾ�����б���ѡ���ļ�
" <Leader>bs ˮƽ�ָ����ʾ�����б����ڻ����б����д�ѡ���ļ�
" <Leader>bv ��ֱ�ָ����ʾ�����б����ڻ����б����д�ѡ���ļ�
 
" -----------------------------------------------------------------------------
"  < ccvext.vim ������� >
" -----------------------------------------------------------------------------
" ���ڶ�ָ���ļ��Զ�����tags��cscope�ļ�������
" �����Windowsϵͳ, �����ɵ��ļ���Դ�ļ������̷���Ŀ¼��.symbsĿ¼��(��: X:\.symbs\)
" �����Linuxϵͳ, �����ɵ��ļ���~/.symbs/Ŀ¼��
" �����÷��ɲο�www.vim.org�д˲����˵��
" <Leader>sy �Զ�����tags��cscope�ļ�������
" <Leader>sc �����Ѵ��ڵ�tags��cscope�ļ�
 
" -----------------------------------------------------------------------------
"  < cSyntaxAfter ������� >
" -----------------------------------------------------------------------------
" �����������������
au! BufRead,BufNewFile,BufEnter *.{c,cpp,h,java,javascript} call CSyntaxAfter()
 
" -----------------------------------------------------------------------------
"  < ctrlp.vim ������� >
" -----------------------------------------------------------------------------
" һ��ȫ·��ģ���ļ�����������������ʹ�ã�... �����������ϸ������ :h ctrlp
" ����ģʽ�����룺Ctrl + p ���ò��
 
" -----------------------------------------------------------------------------
"  < emmet-vim��ǰ��ΪZen coding�� ������� >
" -----------------------------------------------------------------------------
" HTML/CSS������ٱ�д��������ϸ������ :h emmet.txt
 
" -----------------------------------------------------------------------------
"  < indentLine ������� >
" -----------------------------------------------------------------------------
" ������ʾ�����ߣ��� indent_guides ����ʾ��ʽ�ϲ�ͬ�������Լ�ϲ��ѡ����
" ���ն��ϻ�����Ļˢ�µ����⣬��������ܽ���и�����
" ����/�رն�����
nmap <leader>il :IndentLinesToggle<CR>
 
" ����Gvim�Ķ�������ʽ
if g:isGUI
    let g:indentLine_char = "��"
    let g:indentLine_first_char = "��"
endif
 
" �����ն˶�������ɫ�������ϲ�����Խ���ע�͵�����Ĭ����ɫ
let g:indentLine_color_term = 239
 
" ���� GUI ��������ɫ�������ϲ�����Խ���ע�͵�����Ĭ����ɫ
" let g:indentLine_color_gui = '#A4E57E'
 
" -----------------------------------------------------------------------------
"  < vim-javacompleteex��Ҳ���� javacomplete ��ǿ�棩������� >
" -----------------------------------------------------------------------------
" java ��ȫ���
 
" -----------------------------------------------------------------------------
"  < Mark--Karkat��Ҳ���� Mark�� ������� >
" -----------------------------------------------------------------------------
" ����ͬ�ĵ��ʸ�����������ͬ�ı���ʱ�����ã���ϸ������ :h mark.txt
 
" " -----------------------------------------------------------------------------
" "  < MiniBufExplorer ������� >
" " -----------------------------------------------------------------------------
" " ��������Ͳ���Buffer
" " ��Ҫ����ͬʱ�򿪶���ļ��������л�
 
" " let g:miniBufExplMapWindowNavArrows = 1     "��Ctrl�ӷ�����л����������ҵĴ�����ȥ
" let g:miniBufExplMapWindowNavVim = 1        "��<C-k,j,h,l>�л����������ҵĴ�����ȥ
" let g:miniBufExplMapCTabSwitchBufs = 1      "������ǿ����������ֻ����Windows�в����ã�
" "                                            <C-Tab> ��ǰѭ���л���ÿ��buffer��,���ڵ�ǰ���ڴ�
" "                                            <C-S-Tab> ���ѭ���л���ÿ��buffer��,���ڵ�ǰ���ڴ�
 
" �ڲ�ʹ�� MiniBufExplorer ���ʱҲ����<C-k,j,h,l>�л����������ҵĴ�����ȥ
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l
 
" -----------------------------------------------------------------------------
"  < neocomplcache ������� >
" -----------------------------------------------------------------------------
" �ؼ��ֲ�ȫ���ļ�·����ȫ��tag��ȫ�ȵȣ����֣��ǳ����ã��ٶȳ��졣
let g:neocomplcache_enable_at_startup = 1     "vim ����ʱ���ò��
" let g:neocomplcache_disable_auto_complete = 1 "���Զ�������ȫ�б�
" �ڵ�����ȫ�б���� <c-p> �� <c-n> ��������ѡ��Ч���ȽϺ�
 
" -----------------------------------------------------------------------------
"  < nerdcommenter ������� >
" -----------------------------------------------------------------------------
" ����Ҫ����C/C++����ע��(������Ҳ��)
" ����Ϊ���Ĭ�Ͽ�ݼ������е�˵������C/C++Ϊ���ģ�������������
" <Leader>ci ��ÿ��һ�� /* */ ע��ѡ����(ѡ������������)����������ȡ��ע��
" <Leader>cm ��һ�� /* */ ע��ѡ����(ѡ������������)������������ظ�ע��
" <Leader>cc ��ÿ��һ�� /* */ ע��ѡ���л���������������ظ�ע��
" <Leader>cu ȡ��ѡ������(��)��ע�ͣ�ѡ������(��)��������һ�� /* */
" <Leader>ca ��/*...*/��//������ע�ͷ�ʽ���л����������Կ��ܲ�һ���ˣ�
" <Leader>cA ��βע��
let NERDSpaceDelims = 1                     "����ע�ͷ�֮����ע�ͷ�֮ǰ���пո�
 
" -----------------------------------------------------------------------------
"  < nerdtree ������� >
" -----------------------------------------------------------------------------
" ��Ŀ¼��ṹ���ļ�������
 
" ����ģʽ������ F2 ���ò��
nmap <F2> :NERDTreeToggle<CR>
 
" -----------------------------------------------------------------------------
"  < omnicppcomplete ������� >
" -----------------------------------------------------------------------------
" ����C/C++���벹ȫ�����ֲ�ȫ��Ҫ��������ռ䡢�ࡢ�ṹ����ͬ��Ƚ��в�ȫ����ϸ
" ˵�����Բο�����������̵̳�
" ʹ��ǰ��ִ������ ctags ����������п���ֱ��ʹ�� ccvext �����ִ���������
" ctags -R --c++-kinds=+p --fields=+iaS --extra=+q
" ��ʹ������Ĳ������ɱ�ǩ�󣬶Ժ���ʹ����תʱ����ֶ��ѡ��
" �����Ҿͽ�--c++-kinds=+p������ȥ���ˣ����������ʲô�����������ϣ����Ҫ����ѽ
set completeopt=menu                        "�ر�Ԥ������
 
" -----------------------------------------------------------------------------
"  < powerline ������� >
" -----------------------------------------------------------------------------
" ״̬����������õ�״̬��Ч��
 
" -----------------------------------------------------------------------------
"  < repeat ������� >
" -----------------------------------------------------------------------------
" ��Ҫ��"."�������ظ��ϴβ��ʹ�õ�����
 
" -----------------------------------------------------------------------------
"  < snipMate ������� >
" -----------------------------------------------------------------------------
" ���ڸ��ִ��벹ȫ�����ֲ�ȫ��һ�ֶԴ����еĴ����������д��ȫ����ϸ�÷����Բ�
" ��ʹ��˵��������̵̳ȡ�������ʱ��Ҳ���� supertab ����ڲ�ȫʱ������ͻ�������
" ����ʲô�����������ϣ����Ҫ����ѽ
 
" -----------------------------------------------------------------------------
"  < SrcExpl ������� >
" -----------------------------------------------------------------------------
" ��ǿԴ����������书�ܾ���Windows�е�"Source Insight"
nmap <F3> :SrcExplToggle<CR>                "��/���������
 
" -----------------------------------------------------------------------------
"  < std_c ������� >
" -----------------------------------------------------------------------------
" ������ǿC�﷨����
 
" ���� // ע�ӷ��
let c_cpp_comments = 0
 
" -----------------------------------------------------------------------------
"  < surround ������� >
" -----------------------------------------------------------------------------
" ���ٸ�����/�����������ӷ��ţ�����html��ǩ����ȱ���ǲ�����"."���ظ�����
" ���� repeat ������Խ��������⣬��ϸ������ :h surround.txt
 
" -----------------------------------------------------------------------------
"  < Syntastic ������� >
" -----------------------------------------------------------------------------
" ���ڱ����ļ�ʱ����﷨
 
" -----------------------------------------------------------------------------
"  < Tagbar ������� >
" -----------------------------------------------------------------------------
" ��� TagList �ܸ��õ�֧���������
 
" ����ģʽ������ tb ���ò��������д� TagList �������Ƚ���ر�
nmap tb :TlistClose<CR>:TagbarToggle<CR>
 
let g:tagbar_width=30                       "���ô��ڿ��
" let g:tagbar_left=1                         "����ര������ʾ
 
" -----------------------------------------------------------------------------
"  < TagList ������� >
" -----------------------------------------------------------------------------
" ��Ч�����Դ��, �书�ܾ���vc�е�workpace
" �������г��˵�ǰ�ļ��е����к�,ȫ�ֱ���, ��������
 
" ����ģʽ������ tl ���ò��������д� Tagbar �������Ƚ���ر�
nmap tl :TagbarClose<CR>:Tlist<CR>
 
let Tlist_Show_One_File=1                   "ֻ��ʾ��ǰ�ļ���tags
" let Tlist_Enable_Fold_Column=0              "ʹtaglist�������ʾ��ߵ��۵���
let Tlist_Exit_OnlyWindow=1                 "���Taglist���������һ���������˳�Vim
let Tlist_File_Fold_Auto_Close=1            "�Զ��۵�
let Tlist_WinWidth=30                       "���ô��ڿ��
let Tlist_Use_Right_Window=1                "���Ҳര������ʾ
 
" -----------------------------------------------------------------------------
"  < txtbrowser ������� >
" -----------------------------------------------------------------------------
" �����ı��ļ����ɱ�ǩ�����﷨����������TagList������ɱ�ǩ��������ԣ�
au BufRead,BufNewFile *.txt setlocal ft=txt
 
" -----------------------------------------------------------------------------
"  < ZoomWin ������� >
" -----------------------------------------------------------------------------
" ���ڷָ�ڵ�����뻹ԭ
" ����ģʽ�°���ݼ� <c-w>o ������뻹ԭ���л�
 
" =============================================================================
"                          << ����Ϊ���ù������� >>
" =============================================================================
 
" -----------------------------------------------------------------------------
"  < cscope �������� >
" -----------------------------------------------------------------------------
" ��Cscope�Լ��Ļ�˵ - "����԰��������ǳ���Ƶ��ctags"
if has("cscope")
    "�趨����ʹ�� quickfix �������鿴 cscope ���
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    "ʹ֧���� Ctrl+]  �� Ctrl+t ��ݼ��ڴ������ת
    set cscopetag
    "������뷴������˳������Ϊ1
    set csto=0
    "�ڵ�ǰĿ¼������κ����ݿ�
    if filereadable("cscope.out")
        cs add cscope.out
    "����������ݿ⻷������ָ����
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set cscopeverbose
    "��ݼ�����
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif
 
" -----------------------------------------------------------------------------
"  < ctags �������� >
" -----------------------------------------------------------------------------
" ���������ǳ��ķ���,�����ں���,����֮����ת��
set tags=./tags;                            "���ϼ�Ŀ¼�ݹ����tags�ļ�������ֻ����Windows�²����ã�
 
" -----------------------------------------------------------------------------
"  < gvimfullscreen �������� > ��ȷ���Ѱ�װ�˹���
" -----------------------------------------------------------------------------
" ���� Windows Gvim ȫ�����ڣ����� F11 �л�
" ȫ���������ز˵�������������������Ч������
if (g:iswindows && g:isGUI)
    nmap <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
endif
 
" -----------------------------------------------------------------------------
"  < vimtweak �������� > ��ȷ������װ�˹���
" -----------------------------------------------------------------------------
" ����ֻ���ڴ���͸�����ö�
" ����ģʽ�� Ctrl + Up���Ϸ������ ���Ӳ�͸���ȣ�Ctrl + Down���·������ ���ٲ�͸���ȣ�<Leader>t �����ö�����л�
if (g:iswindows && g:isGUI)
    let g:Current_Alpha = 255
    let g:Top_Most = 0
    func! Alpha_add()
        let g:Current_Alpha = g:Current_Alpha + 10
        if g:Current_Alpha > 255
            let g:Current_Alpha = 255
        endif
        call libcallnr("vimtweak.dll","SetAlpha",g:Current_Alpha)
    endfunc
    func! Alpha_sub()
        let g:Current_Alpha = g:Current_Alpha - 10
        if g:Current_Alpha < 155
            let g:Current_Alpha = 155
        endif
        call libcallnr("vimtweak.dll","SetAlpha",g:Current_Alpha)
    endfunc
    func! Top_window()
        if  g:Top_Most == 0
            call libcallnr("vimtweak.dll","EnableTopMost",1)
            let g:Top_Most = 1
        else
            call libcallnr("vimtweak.dll","EnableTopMost",0)
            let g:Top_Most = 0
        endif
    endfunc
 
    "��ݼ�����
    nmap <c-up> :call Alpha_add()<CR>
    nmap <c-down> :call Alpha_sub()<CR>
    nmap <leader>t :call Top_window()<CR>
endif
 
" =============================================================================
"                          << ����Ϊ�����Զ��������� >>
" =============================================================================
 
" �Զ��л�Ŀ¼Ϊ��ǰ�༭�ļ�����Ŀ¼
au BufRead,BufNewFile,BufEnter * cd %:p:h
 
" =============================================================================
"                     << windows �½�� Quickfix �������� >>
" =============================================================================
" windows Ĭ�ϱ���Ϊ cp936���� Gvim(Vim) �ڲ�����Ϊ utf-8�����Գ������Ϊ����
" ���´�����Խ�����Ϊ cp936 �������Ϣת��Ϊ utf-8 ���룬�Խ�������������
" ������ֻ�������Ϣȫ��Ϊ���Ĳ��������Ч������������Ϣ����Ӣ��ϵģ��ǿ���
" ���ɹ������������һ���������룬�����Ϣȫ��ΪӢ�ĵĺ��񲻻�����
" ��������ϢΪ����Ŀ�����һ������Ĵ��룬������оͻ��Ǹ���ע�͵�
 
" if g:iswindows
"     function QfMakeConv()
"         let qflist = getqflist()
"         for i in qflist
"            let i.text = iconv(i.text, "cp936", "utf-8")
"         endfor
"         call setqflist(qflist)
"      endfunction
"      au QuickfixCmdPost make call QfMakeConv()
" endif
 
" =============================================================================
"                          << ���� >>
" =============================================================================
" ע�����������е�"<Leader>"�ڱ����������Ϊ"\"����������ķ�б�ܣ�����<Leader>t
" ָ�ڳ���ģʽ�°�"\"����"t"�������ﲻ��ͬʱ���������Ȱ�"\"����"t"���������һ
" ���ڣ���<Leader>cs���Ȱ�"\"���ٰ�"c"���ٰ�"s"������Ҫ�޸�"<leader>"�������԰�
" ���������ȡ��ע�ͣ����޸�˫�����еļ�Ϊ����Ҫ�ģ����޸�Ϊ���ż���
 
let mapleader = ";"

" =============================================================================
"                          << ������ת��ݼ� >>
" =============================================================================
" ���α����Ӵ���
nnoremap nw <C-W><C-W>
" ��ת���ҷ��Ĵ���
nnoremap <Leader>lw <C-W>l
" ��ת�����Ĵ���
nnoremap <Leader>hw <C-W>h
" ��ת���Ϸ����Ӵ���
nnoremap <Leader>kw <C-W>k
" ��ת���·����Ӵ���
nnoremap <Leader>jw <C-W>j

