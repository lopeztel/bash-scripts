#! /bin/bash

SAVEIFS=$IFS
IFS=$(echo -en "\n\b") #trick to have spaces in directory names
for d in $(ls -d $1/*/); do 
     directory="${d}compressed_images"
     echo $directory
     #Remove all special characters from directory name to use it as a symlink name
     link_name=$(basename $d | sed 's/ - /-/g; s/, /_/g; s/Ø/O/g; s/ø/o/g; s/Ä/A/g; s/Å/A/g; s/å/a/g; s/Á/A/g; s/á/a/g; s/Ä/A/g; s/ä/a/g; s/Æ/AE/g; s/æ/ae/g; s/Ë/E/g; s/É/E/g; s/é/e/g; s/ë/e/g; s/Í/I/g; s/í/i/g; s/Ï/I/g; s/ï/i/g; s/Ó/O/g; s/ó/o/g; s/Ö/O/g; s/ö/o/g; s/Ú/U/g; s/ú/u/g; s/Ü/U/g; s/ü/u/g; s/Ñ/N/g; s/ñ/n/g; s/ /_/g; s/(//g; s/)//g')
     if [ -L "$link_name" ]; then
         echo "${link_name} - simlynk already exists, skipping..."
     else
         echo "${link_name} - simlynk doesn't exist, creating..."
         echo ln -s $directory $link_name
         ln -s $directory $link_name
         echo "${link_name} - symlink created"
     fi
done  
IFS=$SAVEIFS
