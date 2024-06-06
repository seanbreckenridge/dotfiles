(comment) @comment @spell

[
 ","
 ";"
]@punctuation.delimiter

"=" @operator

(binary_condition_expression
  (binary_condition_identifier) @function.builtin)

(condition_expression
  (unary_condition_identifier) @function.builtin)

(ask) @function.builtin

(string) @string
