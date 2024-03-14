"1.下载plug.vim
" 	- curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" 2.通过下面命令软连接给vim/ideavim的配置文件
" 	- ln -s ~/.vim/vimrc ~/.ideavimrc
" 	- ln -s ~/.vim/vimrc ~/.vimrc
" 3.:PlugInstall
" 4.安装ack。 brew install ack
" =================================================================
let g:configRootDir="~/.vim/"	" 修改为该文件的根目录
let mapleader=" "
set nocompatible				" 关闭对vi的兼容
set encoding=utf-8				" 编码设置
set showmode					" 底部显示模式
set hlsearch					" 高亮搜索
set scrolloff=5
set incsearch					" 搜索时，实时高亮
set ignorecase					" 忽略大小写
set smartcase					" 智能大小写
set history=2000					" 设置历史条数
set showcmd						" 显示当前输入的命令
set laststatus=2				" 下面的状态栏展示两行
filetype on						" 开启文件类型检测

" normal下通过esc关闭高亮
nnoremap <silent> <Esc> :nohlsearch<cr>				

if has('ide')					" ideavim
    echo "Running IdeVim"

    set keep-english-in-normal-and-restore-in-insert		" 自动切输入法插件
    set commentary											" 用gc注释代码
    set easymotion											" 快速跳转到指定字符
	set ReplaceWithRegister									" 用gr来粘贴字符串
    set NERDTree											" 目录插件
    set quickscope											" f/t跳转时高亮
    let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']		" 触发的按键
    let g:qs_lazy_highlight = 1								" 没按f/t时不高亮


	Plug 'machakann/vim-highlightedyank'					" 复制时高亮
	let g:highlightedyank_highlight_duration = "200"		" 设置高亮时间

    set ideajoin											" 智能连接。如字符串、表达式从两行连接成1行时，智能重构
    set ideastatusicon=gray                                 " ideavim图标设为灰色
    set idearefactormode=keep                               " 所有mode下都可以使用idea的重构代码能力
    map <leader>f <Plug>(easymotion-s)
    
	map <C-t> :NERDTreeToggle<CR>
	map <C-f> :NERDTreeFind<CR>

    map <leader>d <Action>(Debug)
    map <leader>r <Action>(Run)
    "map <leader>c <Action>(Stop)
    "map <leader>z <Action>(ToggleDistractionFreeMode)

    map <leader>s <Action>(SelectInProjectView)
    map <leader>a <Action>(Annotate)
    "map <leader>h <Action>(Vcs.ShowTabbedFileHistory)
    map <S-Space> <Action>(GotoNextError)

    "map <leader>o <Action>(FileStructurePopup)

    " 简单的方案解决*/#查询选择区域，对于特殊字符可能会有问题，如选中.会查询所有
    vmap * y/<C-R>"<CR>
    vmap # y?<C-R>"<CR>
	
else
    " Running vim
	call plug#begin()
		Plug 'yianwillis/vimcdoc'					" 中文文档插件（需要克隆文档参考https://github.com/yianwillis/vimcdoc）
		Plug 'ghifarit53/tokyonight-vim'			" 夜东京主题插件
    	Plug 'machakann/vim-highlightedyank'		" 复制时高亮
		Plug 'vim-scripts/ReplaceWithRegister'		" 用gr来粘贴字符串
		Plug 'tomtom/tcomment_vim'					" 用gc注释代码
		Plug 'preservim/nerdtree'					" 目录
		Plug 'Xuyuanp/nerdtree-git-plugin'			" 目录支持git状态
		Plug 'easymotion/vim-easymotion'			" 快速跳转字符
		Plug 'voldikss/vim-floaterm'				" 悬浮终端
		Plug 'psliwka/vim-smoothie'					" C-u/d平滑滚动
		Plug 'vim-airline/vim-airline'				" 展示底部状态栏和顶部tab栏
		Plug 'airblade/vim-gitgutter'				" git相关，可在airline中展示变更数量
		Plug 'tpope/vim-fugitive'					" git相关，可在airline中展示分支名
		Plug 'unblevable/quick-scope'				" 高亮f/t
	call plug#end()

    syntax on						" 开启语法高亮
	set termguicolors				" 开启highlight-guifg and highlight-guibg
    set cursorline					" 突出显示当前行
	"set cursorcolumn				" 突出显示当前列
    set number						" 显示行号
    set ruler						" 显示右下角状态，光标当前的位置
    set tabstop=4 					" 缩进的字符数
	set shiftwidth=4 				" 用>缩进的字符数
    set ttimeoutlen=50				" 太长会导致esc按了之后得等待一会

	" insert离开时，*匹配的文件（任意文件）执行外部命令!/opt/homebrew/bin/im-select com.apple.keylayout.ABC
	" 需要先安装im-select工具https://github.com/daipeihust/im-select
    autocmd InsertLeave * :silent !/opt/homebrew/bin/im-select com.apple.keylayout.ABC

    " 映射*/#为查询下/上一处选中字符串，ideavim中不支持（原因未知，ideavim中用简单的方法实现）
    xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
    xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
    function! s:VSetSearch(cmdtype)
        norm! gv"sy
        let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    endfunction

    " 修改insert/normal/replace下的光标
    let &t_SI = "\<Esc>[5 q"
    let &t_SR = "\<Esc>[4 q"
	let &t_EI = "\<Esc>[1 q"

	" 配置夜东京主题
	let g:tokyonight_style = 'night' 		" available: night, storm
	let g:tokyonight_enable_italic = 1
	let g:tokyonight_transparent_background	=1
	colorscheme tokyonight
	highlight Visual guibg=#3498db			" 选中的背景色
	highlight Visual guifg=white			" 选中的前景色
	highlight Comment guifg=#57606f			" 注释的前景色
	highlight CursorLine guibg=#41435e		" 当前行高亮的颜色
	highlight CursorColumn guibg=#41435e	" 当前列高亮的颜色

	
	" 配置vim-highlightedyank插件
	let g:highlightedyank_highlight_duration = 200		" 高亮时间
    highlight HighlightedyankRegion guibg=#3498db		" 高亮颜色
	
	" 配置easymotion
	map  <Leader>f <Plug>(easymotion-s)
	
	" 配置NERDTree
	nnoremap <C-t> :NERDTreeToggle<CR>
	nnoremap <C-f> :NERDTreeFind<CR>

	" 配置悬浮终端
	let g:floaterm_keymap_new = '<Leader>tw'     " 新建终端。
	let g:floaterm_keymap_toggle = '<Leader>tt'  " 终端显隐。
	let g:floaterm_keymap_prev = '<Leader>tp'    " 上一个终端。
	let g:floaterm_keymap_next = '<Leader>tn'    " 下一个终端。
	let g:floaterm_keymap_kill = '<Leader>tk'    " 关掉终端。
	let g:floaterm_wintype = 'float'             " 浮动窗口类型。
	let g:floaterm_position = 'right'            " 在窗口中间显示。


	" 配置airline
	let g:airline_left_sep = ' '
	let g:airline_right_sep = ''
	let g:airline_section_y = '%p%%'
	let g:airline_section_z = '%v:%l/%L'
	let g:airline#extensions#default#layout = 
				\	[['a', 'b', 'c'], ['y', 'z']]
	if !exists('g:airline_symbols')
		let g:airline_symbols = {}
	endif
	let g:airline#extensions#branch#enabled=1
	let g:airline_symbols.readonly = ''
	let g:airline_symbols.dirty=''								" buffer dirty后分支名后的符号
	let g:airline_symbols.branch = ''							" branch前面的符号
	let g:airline#extensions#tabline#enabled = 1				" 显示顶部tabline
	let g:airline#extensions#tabline#buffer_nr_show = 1			" 显示buffer的index
	let g:airline#extensions#tabline#formatter = 'unique_tail'	" tabline优先仅展示文件名

	" 配置折叠,每次进入/关闭buffer时，保存/加载折叠
	autocmd BufWrite * :silent mkview
	autocmd BufRead * :silent loadview

	" 配置quickScope
	let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

	" 支持markdown
	execute 'source' configRootDir . 'myscript/markdown.vim'
	command Gitdiff execute "GitGutterDiffOrig"
		
	" 配置ack,使用ack代替系统grep，并支持跳转到列
	set grepprg=ack\ --nogroup\ --column\ $*
	set grepformat=%f:%l:%c:%m
endif
