#!/usr/bin/env bash
#
# set-default-apps.sh
#
# sets the default application for a bunch of file extensions
# requires 'duti', which should have been installed with 'homebrew/Brewfile'
# or 'brew install duti'

# if we're not on mac, exit
if [[ $(uname -s) == "Darwin" ]]; then
    if [[ ! $(command -v duti) ]]; then
        echo -e "'duti' isn't installed. Install it with:\\n\\tbrew install duti"
        exit 1
    fi
else
    echo "Not on Mac, exiting..."
    exit 1
fi

audio=(
    ".aac"
    ".mp3"
    ".opus"
    ".aiff"
    ".wav"
    ".ogg"
    ".ac3"
    ".flac"
    ".alac"
    ".wma"
    ".m4a"
    ".ape"
    ".mka"
)

video=(
    ".webm"
    ".mpg"
    ".mp2"
    ".mpeg"
    ".mpe"
    ".mpv"
    ".mp4"
    ".m4p"
    ".m4v"
    ".mkv"
    ".flv"
    ".f4v"
    ".gif"
    ".ogv"
    ".gifv"
    ".avi"
    ".qt"
    ".wmv"
    ".m2v"
    ".3gp"
    ".3g2"
    ".f4p"
)

for i in "${!audio[@]}"; do
    duti -s $(osascript -e 'id of app "VLC"') "${audio[$i]}" all
done

for i in "${!video[@]}"; do
    duti -s $(osascript -e 'id of app "VLC"') "${video[$i]}" all
done

# use an extension in chrome/firefox to preview markdown files
# https://addons.mozilla.org/en-US/firefox/addon/markdown-viewer-webext/
# https://chrome.google.com/webstore/detail/markdown-preview-plus/febilkbfcbhebfnokafefeacimjdckgl
duti -s $(osascript -e 'id of app "Firefox"') ".md" all
