This is used to run background processes

Typically one would just use cron or a systemd service, but nothing ever seems to be cross platform enough for me. Also, cron always feels like a hack when a requirement is syncing my scripts into git -- either you have to specify a full $PATH (so it works on mac), put things not in your $HOME directory, or do some symlinking, and none of those are things I'm a fan of.

supervisord is typically used to respawn processes on servers, but I've had a nice experience with it, so might as well try it here

On linux, I can spawn this by 'exec'ing at the OS level (i.e. on Arch/i3, i3-exec). On mac, a terminal window spawns when I log in and runs in the foreground

The 'super' script is the entrypoint to this folder, it uses the 'supervisord.conf' file to determine how to run each of the background processes

```
$ super --ctl status
bgproc                           RUNNING   pid 99233, uptime 0:30:10
linux_tasks                      RUNNING   pid 99234, uptime 0:30:10
mpv_history_daemon_watcher       RUNNING   pid 99235, uptime 0:30:10
window_watcher                   RUNNING   pid 99236, uptime 0:30:10
```

