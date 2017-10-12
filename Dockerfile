FROM ubuntu:16.04
MAINTAINER Yasushi Kobayashi <ptpadan@gmail.com>

RUN apt-get update && \
  apt-get install -y wget curl git build-essential pkg-config gzip ca-certificates && \
  rm -rf /var/lib/apt/lists/*

# setup golang glide
WORKDIR /usr/local
ENV GO_V 1.8.3
ENV PATH=$PATH:/usr/local/go/bin
ENV GOPATH=/work/go
ENV PATH=$PATH:$GOPATH/bin
RUN wget -q -O - https://storage.googleapis.com/golang/go${GO_V}.linux-amd64.tar.gz | tar zxf - && \
  mkdir -p $GOPATH

# Install webp
ENV LIBWEBP_V 0.4.2
RUN apt-get update && \
  apt-get install -y libjpeg-dev libpng-dev libtiff-dev libgif-dev
RUN wget -q -O - http://downloads.webmproject.org/releases/webp/libwebp-${LIBWEBP_V}.tar.gz | tar zxf - && \
  cd libwebp-${LIBWEBP_V} && \
  ./configure && \
  make && make install && make clean

# install imagemagick
WORKDIR /tmp
ENV IMAGE_MAGIC_V 7.0.7-7
RUN wget -q -O - http://www.imagemagick.org/download/ImageMagick-${IMAGE_MAGIC_V}.tar.gz | tar zxf - && \
  cd ImageMagick-* && \
  ./configure && \
  make && make install && make clean && \
  ldconfig /usr/local/lib
