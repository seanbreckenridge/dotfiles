; extends

; https://github.com/seanbreckenridge/evry
; evry has syntax like:
; evry 1 day -do_some_job
;
; this identifies the -tag as @evry_flag, so it
; can be highlighted
(command
  name: (command_name
    (word) @cmd_name)
  (#eq? @cmd_name "evry")
  argument: (word) @evry_flag
  (#match? @evry_flag "^-")) @evry

; can then use a command like this to highlight it specifically:
; highlight @evry_flag cterm=italic gui=italic guifg=grey
