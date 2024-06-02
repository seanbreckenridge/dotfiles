;; Highlight awk strings in shell scripts using the AWK syntax
;; TODO: only do this when the raw_string is the last argument in the command

(command
 name: (command_name
    (word) @cmd_name
    (#eq? @cmd_name "awk")
    )
 argument: (raw_string) @injection.content
 (#set! injection.language "awk")
 ) @awk

;; NOTE: This does not do a *ton*, but it does highlight ^ and $ nicely
(command
 name: (command_name
    (word) @cmd_name
    (#eq? @cmd_name "sed")
    )
 argument: (raw_string) @injection.content
 (#set! injection.language "regex")
 ) @sed

(command
 name: (command_name
    (word) @cmd_name
    (#eq? @cmd_name "jq")
    )
 argument: (raw_string) @injection.content
 (#set! injection.language "jq")
 ) @jq

;; https://github.com/seanbreckenridge/fzfcache
(command
 name: (command_name
    (word) @cmd_name
    (#eq? @cmd_name "fzfcache"))
 argument: (string (string_content) @injection.content)
 (#set! injection.language "bash")
 ) @bash
