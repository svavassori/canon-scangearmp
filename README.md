# Canon ScanGear MP 1.60-1 source code and build instructions

## Original Canon ScanGear MP sources
The orginal Canon ScanGear MP sources have been downloaded from: 
http://gdlp01.c-wss.com/gds/3/0100003033/01/scangearmp-source-1.60-1.tar.gz

```text
Name: scangearmp-source-1.60-1.tar.gz
Size: 3931034 bytes
Last modified date: 3 set 2010
Hashes:
   MD5: 15782d670f9d5c5904e00610508114f3  scangearmp-source-1.60-1.tar.gz
  SHA1: 9adfb9f4fc0177445489d51b03e52d60eed124dc  scangearmp-source-1.60-1.tar.gz
SHA256: fab6b764409f17a674ba31e45a515353cdf027562b2daee96c316bb86d6d6340  scangearmp-source-1.60-1.tar.gz
```

## How to build the binary package

```bash
docker build -t canon-build-env:1 .
docker run --rm --ulimit "nofile=1024:1048576" -v $(pwd):/build -it -u $(id -u):$(id -g) canon-build-env:1
cd /build/scangearmp-source-1.60-1
dpkg-buildpackage
```

## Run from a docker container

```bash
xauth list (to show magic cookie)
docker run --rm -it --privileged -v $(pwd):/debs -v /dev/bus/usb:/dev/bus/usb -v /tmp/.X11-unix/:/tmp.X11-unix -e DISPLAY=$DISPLAY --net=host debian:12.5 bash
apt-get update
apt-get install xauth
xauth add <magic-cookie>
cd /debs
apt-get install ./*.deb
scangearmp
```

## Variables to set in ~/.quiltrc to work with quilt patches

This .quiltrc is already set in the Dockerfile in `/tmp/.quiltrc`,
it is not needed if you just build the package.

```bash
cat <<EOF >> ~/.quiltrc
QUILT_PATCHES=debian/patches
QUILT_SERIES=debian/patches/series
QUILT_DIFF_ARGS="--no-timestamps --no-index -pab"
QUILT_REFRESH_ARGS="--no-timestamps --no-index -pab"
QUILT_PATCH_OPTS="--reject-format=unified"
EOF
```
