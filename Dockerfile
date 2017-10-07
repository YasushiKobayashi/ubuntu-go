FROM ubuntu:16.04
MAINTAINER Yasushi Kobayashi <ptpadan@gmail.com>

RUN apt-get update && \
  apt-get install -y wget curl git build-essential pkg-config gzip

# setup golang glide
WORKDIR /usr/local
ENV GO_V 1.8.3
ENV PATH=$PATH:/usr/local/go/bin
ENV GOPATH=/work/go
ENV PATH=$PATH:$GOPATH/bin
RUN wget https://storage.googleapis.com/golang/go${GO_V}.linux-amd64.tar.gz && \
  tar -zxvf go${GO_V}.linux-amd64.tar.gz && \
  mkdir -p $GOPATH/bin && \
  curl https://glide.sh/get | sh

# Install webp
RUN apt-get -q -y install libjpeg-dev libpng-dev libtiff-dev libgif-dev
RUN wget http://downloads.webmproject.org/releases/webp/libwebp-0.4.2.tar.gz && \
	tar xvzf libwebp-0.4.2.tar.gz && \
	cd libwebp-0.4.2 && \
	./configure && \
	make && make install

# install imagemagick
WORKDIR /tmp
ENV IMAGE_MAGIC_V 7.0.7-6
RUN wget http://www.imagemagick.org/download/ImageMagick-${IMAGE_MAGIC_V}.tar.gz && \
	tar xvzf ImageMagick-${IMAGE_MAGIC_V}.tar.gz && \
	cd ImageMagick-* && \
	./configure && \
	make && make install && \
	ldconfig /usr/local/lib
