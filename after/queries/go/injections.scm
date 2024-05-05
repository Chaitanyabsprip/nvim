; extends

; (assignment
;     left: (identifier) @_id
;     right: (goRawString (String) @injection.content)
;     (#match? @_id "py")
;     (#set! injection.language "python"))

((short_var_declaration
    left: (expression_list
            (identifier) @_var)
    right: (expression_list
             (raw_string_literal) @python))
  (#lua-match? @_var "py.*")
  (#offset! @python 0 1 0 -1))

; nvim 0.10

(const_spec
  name: ((identifier) @_const(#lua-match? @_const "py.*"))
  value: (expression_list (raw_string_literal) @injection.content
   (#set! injection.language "python")))

(short_var_declaration
    left: (expression_list (identifier) @_var (#lua-match? @_var "py.*"))
    right: (expression_list (raw_string_literal) @injection.content)
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "python"))

(short_var_declaration
    left: (expression_list (identifier) @_var (#lua-match? @_var "py.*"))
    right: (expression_list (raw_string_literal) @injection.content)
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "python"))

(var_spec
  name: ((identifier) @_const(#lua-match? @_const "py.*"))
  value: (expression_list (raw_string_literal) @injection.content
   (#set! injection.language "python")))

(short_var_declaration
    left: (expression_list (identifier) @_var (#lua-match? @_var "py.*"))
    right: (expression_list (call_expression
            function: (selector_expression) @_fun
            arguments: (argument_list (raw_string_literal) @injection.content)
      ))
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "python")
)
