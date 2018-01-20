" Vim color file
" Maintainer:	Umut Topuzoğlu

hi clear

let g:colors_name = "bluloco-dark"

" Normal should come first
hi Normal     guifg=Black  guibg=White
hi Cursor     guifg=bg     guibg=fg
hi lCursor    guifg=NONE   guibg=Cyan

" Note: we never set 'term' because the defaults for B&W terminals are OK
hi DiffAdd    ctermbg=LightBlue    guibg=LightBlue
hi DiffChange ctermbg=LightMagenta guibg=LightMagenta
hi DiffDelete ctermfg=Blue	   ctermbg=LightCyan gui=bold guifg=Blue guibg=LightCyan
hi DiffText   ctermbg=Red	   cterm=bold gui=bold guibg=Red
hi Directory  ctermfg=DarkBlue	   guifg=Blue
hi ErrorMsg   ctermfg=White	   ctermbg=DarkRed  guibg=Red	    guifg=White
hi FoldColumn ctermfg=DarkBlue	   ctermbg=Grey     guibg=Grey	    guifg=DarkBlue
hi Folded     ctermbg=Grey	   ctermfg=DarkBlue guibg=LightGrey guifg=DarkBlue
hi IncSearch  cterm=reverse	   gui=reverse
hi LineNr     ctermfg=8	   guifg=DarkGrey
hi ModeMsg    cterm=bold	   gui=bold
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

hi Comment    cterm=NONE ctermfg=242   gui=NONE   guifg=red2
hi Constant   cterm=NONE ctermfg=170   gui=NONE   guifg=green3
hi Number     cterm=NONE ctermfg=170   gui=NONE   guifg=green3
hi Identifier cterm=NONE ctermfg=42    gui=NONE   guifg=cyan4
hi PreProc    cterm=NONE ctermfg=39    gui=NONE   guifg=magenta3
hi Special    cterm=NONE ctermfg=209   gui=NONE   guifg=deeppink
hi Statement  cterm=NONE ctermfg=39	   gui=NONE   guifg=blue
hi Type	      cterm=NONE ctermfg=204  gui=NONE   guifg=blue
hi String     cterm=NONE ctermfg=222   gui=NONE   guifg=yellow
hi Operator   cterm=NONE ctermfg=105
hi Field      cterm=NONE ctermfg=138   gui=NONE


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

" vim: sw=2
