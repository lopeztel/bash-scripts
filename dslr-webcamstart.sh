#!/bin/bash
#https://www.youtube.com/watch?v=TsuY4o2zLVQ
# sudo modprobe v4l2loopback exclusive_caps=1 card_label="GPhoto2 Webcam"
# gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video0
gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuyv422 -threads 0 -f v4l2 /dev/video2
