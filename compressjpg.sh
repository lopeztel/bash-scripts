#!/bin/sh
mkdir -p compressed_images
mkdir -p resized_images

for file in ./*.jpg ./*.jpeg ./*.JPG; do
	echo "resizing and optimizing $file ..."
	convert "$file" \
		-resize '1920x1080>' \
		"./resized_images/$file"
	jpegoptim "./resized_images/$file" \
		-d './compressed_images' \
		--max 65 \
		--all-progressive \
		-p
	done

echo "renaming pictures according to creation date..."
for i in ./compressed_images/*; do
	jhead -n%Y%m%d-%H%M%S $i
done

echo "deleting transient directory..."
rm -rf resized_images
echo "done!"
