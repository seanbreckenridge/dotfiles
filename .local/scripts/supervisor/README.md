This is used to run background processes

Typically one would just use `cron` or a `systemd` service, but nothing ever seems to be cross platform enough for me.

Also, `cron` always feels like a hack when a requirement is syncing my scripts into git -- either you have to specify a full $PATH (so it works on mac), put things not in your $HOME directory, or do some symlinking, and none of those are things I'm a fan of.

supervisord is typically used to respawn processes on servers, but I've had a nice experience with it, so might as well try it here

On Linux, I can spawn this by 'exec'ing at the OS level (i.e. on Arch/i3, i3-exec). On mac, I check if this is running whenever I open a (see [`$ZDOTDIR/mac.zsh`](https://github.com/seanbreckenridge/dotfiles/blob/master/.config/zsh/mac.zsh))

The `super` script is the entrypoint to this folder, it uses the `supervisord.conf` file to determine how to run each of the background processes

`run_jobs` uses [`bgproc`](https://github.com/seanbreckenridge/bgproc), which is an anacron-like script I use to schedule tasks periodically

```
$ super --ctl status
active_window                    RUNNING   pid 32014, uptime 0:00:52
bgproc                           RUNNING   pid 32015, uptime 0:00:52
linux_tasks                      RUNNING   pid 32016, uptime 0:00:52
mpv_history_daemon_watcher       RUNNING   pid 32018, uptime 0:00:52
```
