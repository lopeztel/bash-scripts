#!/bin/sh
mkdir -p converted_videos

for file in ./*.MOV ./*.mov ./*.MPG ./*.AVI;  do
	echo "converting file $file ..."
	ffmpeg -i "$file" -vcodec h264 -acodec mp2 "./converted_videos/$file".mp4
done

#Assuming there are mp4 files in the directory move them all to the same directory
mv *.mp4 converted_videos/

echo "Finished video conversion..."
