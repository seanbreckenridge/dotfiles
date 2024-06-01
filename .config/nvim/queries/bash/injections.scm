; TODO: only do this when the raw_string is the last argument in the command

(command
    name: (command_name
      (word) @cmd_name
      (#eq? @cmd_name "awk")
    )
    argument: (raw_string) @injection.content .
    (#set! injection.language "awk")
) @awk
