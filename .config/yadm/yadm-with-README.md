##### yadm with a README.md

Since yadm acts directly on the `$HOME` directory instead of symlinking,
in order to have a README for this repo without polluting `$HOME` with a `README.md`
file, this uses hooks located at [.config/yadm/hooks](hooks) to temporarily copy
the `README.md` to `$HOME` while committing, and then deleting it afterwards.

There's another hook that moves `~/README.md` to `~/.config/yadm/README.md` `post-merge`, so that
README changes done through the web interface stay updated locally.

As long as you're on `git>=2.9`, you can use `core.hooksPath` to change the hooks dir.

After cloning, that can be setup by doing:

```
yadm gitconfig core.hooksPath ~/.config/yadm/hooks
```

Then, by editing the README at `~/.config/yadm/README.md` locally,
it gets added automatically to the next commit. If you want to commit
just the `README.md` for some changes, you can do `yadm commit --allow-empty`
