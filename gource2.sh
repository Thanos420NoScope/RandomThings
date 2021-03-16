#!/bin/bash

# Output temp
OUT_PPM="out.ppm"
# Output
OUT_MP4="video.mp4"
# Background
BG="background.jpg"
# Avatars
AVA="tmp/avatars"


# Create data
gource -1920x1080 -o $OUT_PPM --camera-mode overview --font-colour a290b1 \
       --background-image $BG --highlight-users --highlight-colour e0eeee \
	   --auto-skip-seconds 0.01 --seconds-per-day 0.2 --title "Kadena" --user-scale 1.5 \
	   --user-image-dir $AVA --bloom-multiplier 0.2 --bloom-intensity 0.5 \
	   --key --file-extensions combo.log --file-idle-time 0 --max-file-lag 1 \
	   --hide filenames,progress,mouse --dir-name-depth 2 --multi-sampling --max-user-speed 1500 \
	   --start-date "2016-09-30" --dir-name-position 1

# Make video
ffmpeg -y -r 60 -f image2pipe -vcodec ppm -i $OUT_PPM -vcodec libx264 -preset ultrafast \
       -pix_fmt yuv420p -crf 1 -threads 0 -bf 0 $OUT_MP4

echo "check $OUT_MP4"
rm -f $OUT_PPM
