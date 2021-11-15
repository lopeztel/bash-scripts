#!/bin/sh
echo "Generating .gif for $1..."
palette="temp_palette.png"
filters="fps=7,scale=480:-1:flags=lanczos"
ffmpeg -v warning -i $1 -vf "$filters,palettegen=stats_mode=diff" -y $palette
ffmpeg -i $1 -i $palette -lavfi "$filters,paletteuse=dither=bayer:bayer_scale=5:diff_mode=rectangle" -y $2
echo "Removing $palette..."
rm $palette
echo "Generated $2...Done!"
# ffmpeg -i "$1" -vf "fps=24,scale=1080:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 "$2"

