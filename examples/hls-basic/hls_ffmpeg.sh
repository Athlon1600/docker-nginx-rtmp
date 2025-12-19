#!/bin/sh
set -e

APP="$1"
STREAM="$2"
OUT="/var/www/hls/$STREAM"

echo "Starting FFmpeg for $APP/$STREAM"

# ffmpeg will crash unless destination directory exists
mkdir -p "$OUT"

# small delay so RTMP is ready
sleep 3

exec /usr/local/bin/ffmpeg \
  -analyzeduration 0 \
  -i "rtmp://127.0.0.1:1935/$APP/$STREAM" \
  -c:v copy \
  -c:a copy \
  -f hls \
  -hls_time 6 \
  -hls_list_size 10 \
  -hls_flags delete_segments+independent_segments \
  -hls_start_number_source epoch \
  "$OUT/master.m3u8"
