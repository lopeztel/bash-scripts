#!/bin/sh
for D in *; do
    if [ -d "$D" ]; then
        cd "$D"
        echo "Current directory: ${D}"
        echo "Moving files"
        mv converted_videos/*.mp4 compressed_images/
        echo "Done!"
        echo "Removing converted_videos directory"
        rm -r converted_videos
        echo "Done!"
        cd ../
    fi
done
