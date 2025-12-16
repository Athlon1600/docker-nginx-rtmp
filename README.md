[![Build status](https://github.com/Athlon1600/docker-nginx-rtmp/actions/workflows/docker-build-push.yml/badge.svg)](https://github.com/Athlon1600/docker-nginx-rtmp/actions/workflows/docker-build-push.yml)
![Docker Pulls](https://img.shields.io/docker/pulls/athlon1600/nginx-rtmp)

# Nginx with RTMP module

This repository contains multiple Docker images that basically contain:

- Nginx version 1.22.1 (compiled from source)
- with RTMP module (https://github.com/sergey-dryabzhinsky/nginx-rtmp-module)
- FFmpeg (optional)

This specialized version of Nginx is very useful with anything to do with video livestreaming.
See what you can do with it in the examples folder.

## Contents

For now there is just Debian (that uses **glibc** library), and Alpine (**musl libc**). More images can be added later.

| Linux Image               | FFmpeg? | Size     | Pull Command                                          |
|---------------------------|---------|----------|-------------------------------------------------------|
| Debian 12 (bookworm:slim) | ❌       | 34.29 MB | ```docker pull athlon1600/nginx-rtmp:debian```        |
| Debian 12 (bookworm:slim) | ✔️       | 91.82 MB | ```docker pull athlon1600/nginx-rtmp:debian-ffmpeg``` |
| Alpine 3.16               | ❌       | 7.64 MB  | ```docker pull athlon1600/nginx-rtmp:alpine```        |
| Alpine 3.16               | ✔️       | 65.17 MB | ```docker pull athlon1600/nginx-rtmp:alpine-ffmpeg``` |

> [!NOTE]  
> `:latest` tag just maps onto `nginx-rtmp:debian-ffmpeg`

so these two commands are identical:

```shell
docker pull athlon1600/nginx-rtmp:latest
docker pull athlon1600/nginx-rtmp:debian-ffmpeg
```


## Usage

Pull down the image of your liking, and then you can either run it straight out of the box using the default `nginx.conf` file:

```shell
docker run --rm -p 80:80 -p 1935:1935 athlon1600/nginx-rtmp:latest
```

or you can provide your own custom `nginx.conf`:

```shell
docker run --rm -p 80:80 -p 1935:1935 -v ${PWD}/nginx.conf:/etc/nginx/nginx.conf:ro athlon1600/nginx-rtmp:latest
```

See examples directory for more ideas.

## :heavy_check_mark: To-do List

- [ ] Provide additional Docker images that use RTMP module forks other than one from @sergey-dryabzhinsky
- [ ] Build linux/arm64 architecture variant
- [ ] More Dockerfiles that include ffmpeg builds optimized to use hardware encoding

