" Vim color file
" Maintainer:	Umut Topuzoğlu

hi clear

let g:colors_name = "bluloco-dark"

" Normal should come first
hi Normal     ctermfg=249  ctermbg=236  guifg=#b9c0cb  guibg=#282c34
hi Cursor                               guifg=#282c34  guibg=#ffcc00
hi lCursor                              guifg=#282c34  guibg=#ffcc00

" Note: we never set 'term' because the defaults for B&W terminals are OK
hi DiffAdd    ctermbg=22        guibg=#2b663f
hi DiffChange ctermbg=24        guibg=#015f88
hi DiffDelete ctermbg=131       guibg=#803434 ctermfg=NONE guifg=NONE
hi DiffText   ctermbg=32      guibg=#177da9

hi Directory  ctermfg=39      	guifg=#10b1fe
hi ErrorMsg   ctermfg=255	      ctermbg=197      guifg=White    guibg=#fc2f52
hi FoldColumn ctermfg=27      	ctermbg=249      guifg=#3476ff  guibg=#b9c0cb
hi Folded     ctermbg=27	      ctermfg=249      guifg=#3476ff  guibg=#b9c0cb
hi IncSearch  cterm=reverse	    gui=reverse
hi LineNr     ctermfg=242       guifg=#747d8d
hi CursorLineNr  ctermfg=Yellow       guifg=#ffcc00
hi MatchParen ctermfg=249  ctermbg=105   guibg=#7a82da guifg=#b9c0cb
hi ModeMsg    cterm=bold	ctermfg=Yellow      gui=bold guifg=#ffcc00
hi MoreMsg    ctermfg=42        gui=bold guifg=#25a45c
hi Pmenu      ctermbg=105       guibg=#7a82da
hi PmenuSel   ctermfg=249	 ctermbg=242  guifg=#b9c0cb  guibg=#747d8d
hi Question   ctermfg=42    gui=bold guifg=#25a45c
hi Search     ctermfg=White	   ctermbg=245 guibg=#7a82da guifg=White
hi SpecialKey ctermfg=209	   guifg=#ce9887
hi StatusLine cterm=bold  ctermfg=27  ctermbg=249 gui=bold guifg=#b9c0cb guibg=#3476ff
hi Title      ctermfg=204  gui=bold guifg=#ff6480
hi VertSplit  cterm=reverse	   gui=reverse
hi Visual     ctermbg=NONE	   cterm=reverse  guifg=#3e4452 
hi VisualNOS  cterm=underline,bold gui=underline,bold
hi WarningMsg ctermfg=197	   guifg=#fc2f52
hi WildMenu   cterm=bold ctermfg=27  ctermbg=yellow gui=bold guibg=#ffcc00 guifg=#3476ff

hi TermCursor     cterm=reverse gui=reverse
hi NonText        ctermfg=242 ctermbg=235 gui=bold guifg=#747d8d guibg=#22252a
hi VertSplit      cterm=reverse gui=reverse
hi SignColumn     ctermfg=4 ctermbg=248 guifg=DarkBlue guibg=Grey
hi Conceal        ctermfg=7 ctermbg=242 guifg=LightGrey guibg=DarkGrey
hi SpellBad       ctermbg=224 gui=undercurl guisp=Red
hi SpellCap       ctermbg=81 gui=undercurl guisp=Blue
hi SpellRare      ctermbg=225 gui=undercurl guisp=Magenta
hi SpellLocal     ctermbg=14 gui=undercurl guisp=DarkCyan
hi PmenuSbar      ctermbg=248 guibg=Grey
hi PmenuThumb     ctermbg=0 guibg=Black
hi TabLine        cterm=underline ctermfg=0 ctermbg=7 gui=underline guibg=LightGrey
hi TabLineSel     cterm=bold gui=bold
hi TabLineFill    cterm=reverse gui=reverse
hi CursorColumn   ctermbg=7 guibg=Grey90
hi CursorLine     cterm=underline guibg=Grey90
hi ColorColumn    ctermbg=224 guibg=LightRed
hi Ignore         ctermfg=15 guifg=bg
hi Error          ctermfg=15 ctermbg=9 guifg=White guibg=Red

hi Comment    cterm=NONE ctermfg=242  gui=NONE  guifg=#747d8d
hi Constant   cterm=NONE ctermfg=206  gui=NONE  guifg=#ff78f8
hi Number     cterm=NONE ctermfg=206  gui=NONE  guifg=#ff78f8
hi Identifier cterm=NONE ctermfg=42   gui=NONE  guifg=#3fc56b
hi PreProc    cterm=NONE ctermfg=39   gui=NONE  guifg=#10b1fe
hi Special    cterm=NONE ctermfg=209  gui=NONE  guifg=#ce9887
hi Statement  cterm=NONE ctermfg=39	  gui=NONE  guifg=#10b1fe
hi Type	      cterm=NONE ctermfg=204  gui=NONE  guifg=#ff6480
hi String     cterm=NONE ctermfg=222  gui=NONE  guifg=#f9c859
hi Operator   cterm=NONE ctermfg=105  gui=NONE  guifg=#7a82da
hi Field      cterm=NONE ctermfg=138  gui=NONE  guifg=#ce9887


" javascript
hi link javaScriptBraces Operator
hi link javaScriptParens Operator
hi link javaScriptNumber Number
hi link javaScriptIdentifier Statement
hi link javaScriptFunction Statement
hi link javaScriptBoolean Keyword

" json
hi link jsonBraces Operator
hi link jsonQuote Operator
hi link jsonKeyword Field
hi link jsonKeywordMatch Operator
hi link jsonNoise Operator

" syntax highlighting with terminal own colors
" hi Comment    ctermfg=8     guifg=red2
" hi Constant   ctermfg=13    guifg=green3
" hi Number     ctermfg=13    guifg=green3
" hi Identifier ctermfg=12    guifg=cyan4
" hi PreProc    ctermfg=14    guifg=magenta3
" hi Special    ctermfg=3     guifg=deeppink
" hi Statement  ctermfg=12	  guifg=blue
" hi Type	      ctermfg=9	  guifg=blue
" hi String     ctermfg=11    guifg=yellow
" hi Operator   ctermfg=5     guifg=yellow
" hi Field      ctermfg=138

" ====================================================================================================





" ====================================================================================================
" vim: sw=2
