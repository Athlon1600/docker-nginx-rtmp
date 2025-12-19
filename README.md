[![Build status](https://github.com/Athlon1600/docker-nginx-rtmp/actions/workflows/docker-build-push.yml/badge.svg)](https://github.com/Athlon1600/docker-nginx-rtmp/actions/workflows/docker-build-push.yml)
![Docker Pulls](https://img.shields.io/docker/pulls/athlon1600/nginx-rtmp)

# Nginx with RTMP module

This repository contains everything needed to build the **nginx-rtmp** Docker image, which includes:

- Nginx version 1.22.1 (compiled from source)
- with RTMP module (https://github.com/sergey-dryabzhinsky/nginx-rtmp-module)
- FFmpeg (optional)

This specialized build of Nginx is very useful when it comes to building anything livestreaming related, given that RTMP is still the most popular protocol for streaming video in real-time.

## Docker Images

See the Docker hub page here:
- https://hub.docker.com/r/athlon1600/nginx-rtmp

For now there is just Debian (that uses **glibc** library), and Alpine (**musl libc**).

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

You can either run it straight out of the box using the default `nginx.conf` file:

```shell
docker run --rm -p 80:80 -p 1935:1935 athlon1600/nginx-rtmp:latest
```

or you can provide your own custom `nginx.conf`:

```shell
## PowerShell
docker run --rm -p 80:80 -p 1935:1935 -v ${PWD}/nginx.conf:/etc/nginx/nginx.conf:ro athlon1600/nginx-rtmp:latest

## Windows CMD
docker run --rm -p 80:80 -p 1935:1935 -v %cd%/nginx.conf:/etc/nginx/nginx.conf:ro athlon1600/nginx-rtmp:latest

## Linux/macOS
docker run --rm -p 80:80 -p 1935:1935 -v $(pwd)/nginx.conf:/etc/nginx/nginx.conf:ro athlon1600/nginx-rtmp:latest
```

To see a complete reference of all the new Nginx directives you can use, 
go here:
- https://github.com/arut/nginx-rtmp-module/wiki/Directives

## Examples

Clone this repository:

```shell
git clone https://github.com/Athlon1600/docker-nginx-rtmp.git
cd docker-nginx-rtmp
```

and then look inside `examples` folder:

- [RTMP to HTTP Live Streaming](examples/hls-basic/)
- [Multistreaming to multiple platform at once](examples/multistream/)

## :warning: Security

Before deploying to production, make sure access rules inside `nginx.conf`
and in other places are not too permissible. For example:

```nginx
## This lets ANYONE stream to your server
allow publish all;

## A better alternative
allow publish YOUR_IP_GOES_HERE;
deny publish all;
```

Otherwise, you can just block unknown traffic at a network level instead:

```shell
# allow RTMP connections from your IP only
iptables -A INPUT -p tcp --dport 1935 -s 203.0.113.10 -j ACCEPT

# drop everything else
iptables -A INPUT -p tcp --dport 1935 -j DROP
```


## :heavy_check_mark: To-do List

- [ ] Provide additional Docker images that use RTMP module forks other than one from @sergey-dryabzhinsky
- [ ] Build linux/arm64 architecture variant
- [ ] More Dockerfiles that include ffmpeg builds optimized to use hardware encoding

