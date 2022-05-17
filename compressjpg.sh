#!/bin/sh
mkdir -p compressed_images
mkdir -p resized_images

echo "Resizing and compressing pictures"
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

echo "done!"

echo "Resizing and compressing pngs"
for file in ./*.png; do
        echo "resizing and optimizing $file ..."
        convert "$file" \
                -resize '1920x1080>' \
                "./resized_images/$file"
        optipng -o7 -out "./compressed_images/$file" \
                "./resized_images/$file"
done
echo "done"

echo "Renaming pictures according to creation date..."
for i in ./compressed_images/*; do
	jhead -n%Y%m%d-%H%M%S $i
done

echo "deleting transient directory..."
rm -rf resized_images
echo "done!"
