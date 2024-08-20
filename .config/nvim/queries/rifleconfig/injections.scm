; extends

; highlight any commands using the bash tree-sitter parser
(command_list
  (command) @injection.content
  (#set! injection.include-children)
  (#set! injection.language "bash"))
