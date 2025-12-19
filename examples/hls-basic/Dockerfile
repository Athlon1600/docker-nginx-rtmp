FROM athlon1600/nginx-rtmp:alpine-ffmpeg

# COPY nginx.conf /etc/nginx/nginx.conf

# ffmpeg helper
COPY hls_ffmpeg.sh /usr/local/bin/hls_ffmpeg.sh
RUN chmod +x /usr/local/bin/hls_ffmpeg.sh

# make sure nginx/ffmpeg have these directories available and accessible
RUN mkdir -p /var/www/hls
RUN chown -R nobody:nobody /var/www/hls
RUN chmod 755 /var/www/hls

EXPOSE 1935
EXPOSE 80

CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
