; highlight sqlite commands in python
(call
  function: (attribute
    object: (identifier) @py_object
    attribute: (identifier) @py_function)
  (#match? @py_function "^execute")
  (#match? @py_object ".*(cur|conn)(ection)?$")
  arguments: (argument_list
    (string
      (string_content) @injection.content))
  (#set! injection.language "sql")) @python_highlight_sqlite
