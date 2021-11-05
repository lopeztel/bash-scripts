
# bash-scripts

This is a collection of convenient bash scripts that I use often

## album\_symlinks.sh

This script navigates a directory containing multiple albums with the hierarchy:

```txt
.photo_album
├── Album_1
│   └── compressed_images
├── Album_2
│   └── compressed_images
└── Album_3
    └── compressed_images

```

And creates symlinks (in the current directory) to the `compressed_images` (if
they don't exist already). Example of usage:

`./album_symlinks.sh /home/user/photo_album`
