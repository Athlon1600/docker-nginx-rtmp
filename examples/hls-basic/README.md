# RTMP to HLS (HTTP Live Streaming)

A very minimal example showing how you can stream video to your `nginx-rtmp` server using RTMP protocol, and then use `ffmpeg`
to convert that streaming video into an HLS compliant playlist, which is how most live streaming sites do it.


## Usage

Adjust configuration in each of these files accordingly:

- `docker-compose.yml`
- `nginx.conf`

and then run:

```shell
docker compose up -d
```

You now have a streaming server that can accept streams at this endpoint:

```text
rtmp://localhost:1935/live/{stream_key}
```

Replace `{stream_key}` with anything you want for now (like `test123`).

Once you started streaming, a live playlist should soon be generated and available over HTTP at:

```text
http://localhost:8080/hls/test123/master.m3u8
```

and now you can use that URL to play your live stream using any video player that supports HLS protocol.

Try VLC Media Player or this:
- https://hlsjs.video-dev.org/demo/

