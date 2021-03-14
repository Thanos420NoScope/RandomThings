#!/bin/bash

# Output temp
OUT_PPM="/tmp/out.ppm"
# Output
OUT_MP4="video.mp4"

# Create data
gource -1280x720 --camera-mode overview --output-ppm-stream $OUT_PPM --font-colour 336699 \
       --background-image background.jpg --highlight-users --highlight-colour e0eeee \
       --auto-skip-seconds 1 --seconds-per-day 0.2 --title "Kadena" --user-scale 1 \
       --user-image-dir tmp/avatars --bloom-multiplier 0.5 --bloom-intensity 0.5 --key \
       --file-extensions combo.log -e 0.5

# Make video
ffmpeg -y -r 25 -f image2pipe -vcodec ppm -i $OUT_PPM -vcodec libx264 -preset ultrafast \
       -pix_fmt yuv420p -crf 1 -threads 0 -bf 0 $OUT_MP4

echo "check $OUT_MP4"
rm -f $OUT_PPM
