" Vim color file
" Maintainer:	Umut Topuzoğlu

hi clear

let g:colors_name = "bluloco-dark"

" Normal should come first
hi Normal     ctermfg=249  ctermbg=236  guifg=#b9c0cb  guibg=#282c34
hi Cursor                               guifg=#282c34  guibg=#ffcc00
hi lCursor                              guifg=#282c34  guibg=#ffcc00

" Note: we never set 'term' because the defaults for B&W terminals are OK
hi DiffAdd    ctermbg=42        guibg=#25a45c
hi DiffChange ctermbg=39        guibg=#3476ff
hi DiffDelete ctermbg=197       guibg=#fc2f52
hi DiffText   ctermbg=39	      guibg=#10b1fe
hi Directory  ctermfg=39      	guifg=#10b1fe
hi ErrorMsg   ctermfg=255	      ctermbg=197      guifg=White    guibg=#fc2f52
hi FoldColumn ctermfg=27      	ctermbg=249      guifg=#3476ff  guibg=#b9c0cb
hi Folded     ctermbg=27	      ctermfg=249      guifg=#3476ff  guibg=#b9c0cb
hi IncSearch  cterm=reverse	    gui=reverse
hi LineNr     ctermfg=242       guifg=#747d8d
hi ModeMsg    cterm=bold	      gui=bold
hi MoreMsg    ctermfg=DarkGreen    gui=bold guifg=SeaGreen
hi NonText    ctermfg=Blue	   gui=bold guifg=gray guibg=white
hi Pmenu      guibg=LightBlue
hi PmenuSel   ctermfg=White	   ctermbg=DarkBlue  guifg=White  guibg=DarkBlue
hi Question   ctermfg=DarkGreen    gui=bold guifg=SeaGreen
if &background == "light"
    hi Search     ctermfg=NONE	   ctermbg=Yellow guibg=Yellow guifg=NONE
else
    hi Search     ctermfg=Black	   ctermbg=Yellow guibg=Yellow guifg=Black
endif
hi SpecialKey ctermfg=DarkBlue	   guifg=Blue

hi StatusLine cterm=bold	   ctermbg=blue ctermfg=yellow guibg=gold guifg=blue
hi StatusLineNC	cterm=bold	   ctermbg=blue ctermfg=black  guibg=gold guifg=blue
hi Title      ctermfg=DarkMagenta  gui=bold guifg=Magenta
hi VertSplit  cterm=reverse	   gui=reverse
hi Visual     ctermbg=NONE	   cterm=reverse gui=reverse guifg=Grey guibg=fg
hi VisualNOS  cterm=underline,bold gui=underline,bold
hi WarningMsg ctermfg=DarkRed	   guifg=Red
hi WildMenu   ctermfg=Black	   ctermbg=Yellow    guibg=Yellow guifg=Black

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

" vim: sw=2
