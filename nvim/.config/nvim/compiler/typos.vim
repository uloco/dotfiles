if exists('current_compiler')
  finish
endif
let current_compiler = 'typos'

CompilerSet makeprg=typos\ --format\ brief
CompilerSet errorformat=%f:%l:%c:\ %trror:\ %m,%f:%l:%c:\ %tarning:\ %m
