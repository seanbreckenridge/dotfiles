;; highlight embedded SQL queries in go
(call_expression
 function: (selector_expression
    operand: (identifier) @module
    (#any-of? @module "db" "tx")
    field: (field_identifier) @name
    (#any-of? @name "Exec" "Query"))
 arguments: (argument_list
   [
     (interpreted_string_literal)
     (raw_string_literal)
   ]
   @injection.content)
 ;; remove the string/backticks at the beginning/end of the string
 (#offset! @injection.content 0 1 0 -1)
 (#set! injection.language "sql")
 ) @go_embedded_sql
