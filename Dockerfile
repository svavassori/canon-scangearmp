FROM debian:12.5

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get upgrade --yes \
    && apt-get install --yes \
            dpkg-dev \
            debhelper-compat \
    && apt-get install --yes --no-install-recommends \
            libcanberra-gtk-module \
            libgimp2.0-dev \
            libsane-dev \
            libtool \
            libusb-dev \
            quilt

COPY <<EOF /tmp/.quiltrc
QUILT_PATCHES="debian/patches"
QUILT_SERIES="debian/patches/series"
QUILT_DIFF_ARGS="--no-timestamps --no-index -pab"
QUILT_REFRESH_ARGS="--no-timestamps --no-index -pab"
QUILT_PATCH_OPTS="--reject-format=unified"
EOF

ENV HOME=/tmp

