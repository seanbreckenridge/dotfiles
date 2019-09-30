Created by [create_readme](./create_readme)

### [720convert](./720convert)
```
converts all inputs on command line to 720p mp4 files.
e.g. 720convert pulpfiction.mp4
```

### [average](./average)
```
Usage:
    average [-h]
    average FILES...

uses the duration script to get the average duration
in seconds of files given on command line

Example usage:
  average ~/Music/some_album/*


```

### [choose](./choose)
```
Choose a random file in this directory.
I often use this to pick a random song or movie to watch.

Usage:
  choose [-o] [-w] [--hidden] [--exec EXEC]
  choose --open --hidden
  choose --open --wait --exec EXEC
  choose --help

Options:
  -o, --open        Open the file using the default file descriptor
  --hidden          Include hidden files; ignored by default
  -w, --wait        Waits for 3 seconds in between --open and --exec.
                        useful if file is being loaded into memory by --open
                        and is being moved/deleted by --exec
  --exec EXEC       Execute an additional shell command, specify file location with {}

exec Example:
  choose --exec "ls -l {}"
  choose --open --wait --exec "rm -i {}"

```

### [create_readme](./create_readme)
```
Creates the README for this bin directory
```

### [decode64](./decode64)
```
Usage:
	decode64 SUBSTR HASH
	decode64 --help

Will repetitvely base64 decode HASH till SUBSTR is in decoded string
If SUBSTR is a number, will decode HASH that many times

```

### [duration](./duration)
```
Usage:
duration [-h]
duration FILENAME...

gives you the duration of a audio/video file
prints a line like:
xxxs|xm:xs|filename
for each file
you can get a specific part of these by using cut:

duration movie.mp4 | cut -d "|" -f 1
duration movie.mp4 | cut -d "|" -f 2
duration movie.mp4 | cut -d "|" -f 3


```

### [gi](./gi)
```
https://www.gitignore.io/docs
get standard gitignore files
use `gi list` to list gitignore files
From: https://github.com/AndrewSB/dotfiles/blob/master/zsh/functions/gi
```

### [gifme](./gifme)
```
Usage:
gifme [-h]
gifme <FILE> <START_TIME> <DURATION> [FPS]

Creates a gif from a video file.

command line arguments:
<FILE> - the path to the movie we're converting
<START_TIME> - the start time of the finished gif
<DURATION> - duration; the length of the video clip after the start time to convert
Time(s) can be in seconds, or it also accepts the "hh:mm:ss[.xxx]" format
[FPS] - (optional) specify an integer fps value. default is 10
For best output, it should be a factor of 100; e.g. 10, 20, 25, 50

e.g. gifme ~/Movies/your-favorite-movie.mp4 00:43:04 5
e.g. gifme ~/Movies/your-favorite-movie.mp4 01:04:02 10.5 25

Note if you want to convert the entire duration for a video file to
a gif, you can provide a duration much higher than the length of the video
e.g. gifme ~/Movies/a-short-video.mkv 0 9999999 10

requires 'imagemagick' and 'ffmpeg'

Modified from: https://github.com/holman/dotfiles/blob/master/bin/movieme


```

### [gitconfig](./gitconfig)
```
print your current git configuration
```

### [gitopen](./gitopen)
```
Opens the current git repository in your browser, if you're in one
```

### [gituser](./gituser)
```
Prints your git username and email for the current repository
Used to manage repository specific credentials for different Github accounts
```

### [moviesearch](./moviesearch)
```
Usage:
    moviesearch MOVIE_NAME... [--help]

searches for a movie on 'trakt' and 'letterboxd', opens search results in your default browser

Example:
    moviesearch the shining

```

### [mp4convert](./mp4convert)
```
converts all inputs on command line to mp4 files.
e.g. 720convert pulpfiction.mp4
```

### [ssh-keygen-best-practices](./ssh-keygen-best-practices)
```
Usage:
    ssh-keygen-best-practices [-h]

Creates a good ssh key
Source: https://security.stackexchange.com/a/144044

scheme: rsa
bits: 4096
OpenSSH format
100 KDF (key derivation function) rounds. Higher numbers result in slower
  passphrase verification and increased resistance to brute-force
  password cracking (should the keys be stolen).

Arguments:
  -h  show help message


```

### [tvsearch](./tvsearch)
```
Usage:
    tvsearch TVSHOW_NAME... [--help]

searches for a tv show on 'trakt', opens search results in your default browser

Example:
    tvsearch the office

```

### [usdate](./usdate)
```
Usage: usdate [-du] [--help]

Prints the date in the US format, because I'm used to the European

-d, --dashes           use dashes instead of forward
                       slashes as seperators
-u --underscores       use underscores instead of forward
                       slashes as seperators
--help                 show this help message

```

### [which-cat](./which-cat)
```
which-cat SHELL_COMMAND [-h]

calls 'which' to locate an executable
prints the contents of the file if it exists, and is readable

Arguments:
  -h  show help message


```

### [yt-dl](./yt-dl)
```
usage: yt-dl [-h] [--open] [--wait] [--name NAME] [--downloads | --tmp]

Download a video using youtube-dl, and then do something with it

optional arguments:
  -h, --help   show this help message and exit
  --open       Open this video after it finishes downloading
  --wait       After this video finishes downloading, wait for the user to hit
               enter, and then open it.
  --name NAME  Change the name from the default youtube-dl file to the passed
               name
  --downloads  Change download destination to ~/Downloads
  --tmp        Download a video to the /tmp directory, it will be deleted on
               computer restart

```
