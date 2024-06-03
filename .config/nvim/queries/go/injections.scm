; highlight embedded SQL queries in go
(call_expression
  function: (selector_expression
    operand: (identifier) @db_object
    (#any-of? @db_object "db" "tx")
    field: (field_identifier) @db_func
    (#any-of? @db_func "Exec" "Query"))
  arguments: (argument_list
    [
      (interpreted_string_literal)
      (raw_string_literal)
    ] @injection.content)
  ; remove the string/backticks at the beginning/end of the string
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "sql")) @go_embedded_sql
