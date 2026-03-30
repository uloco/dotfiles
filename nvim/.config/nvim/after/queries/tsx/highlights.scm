; extends

((comment) @_comment
  (#set! @_comment bo.commentstring "// %s"))

((jsx_opening_element) @_jsx_opening
  (#set! @_jsx_opening bo.commentstring "// %s"))

((jsx_self_closing_element) @_jsx_self_closing
  (#set! @_jsx_self_closing bo.commentstring "// %s"))

((jsx_closing_element) @_jsx_closing
  (#set! @_jsx_closing bo.commentstring "// %s"))
