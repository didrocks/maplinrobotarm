machine := $(shell uname -m)
GOPATH := ${CURDIR}
export GOPATH
ifeq ($(machine),x86_64)
triplet := x86_64-linux-gnu
endif
ifeq ($(machine),armv7l)
triplet := arm-linux-gnueabihf
endif
ifeq ($(triplet),)
$(error Unknown machine $(machine))
endif

default: snappy-build

snappy-build:
	snappy build .

mra=maplinrobotarm
mraw=maplinrobotarmweb

build-go:
	# not using "go install" as that would write to bin/$name which is
	# where the arch-indep symlinks live
	#GOARCH=arm make build-go
	#GOARCH=arm make build-go machine=armv7l
	
	go build $(mra)
	go build $(mraw)
	mkdir -p bin/x86_64-linux-gnu
	mv $(mra) $(mraw) bin/x86_64-linux-gnu
	GOARCH=arm GOARM=7 go build $(mraw)
	GOARCH=arm GOARM=7 go build $(mra)
	mkdir -p bin/arm-linux-gnueabihf
	mv $(mra) $(mraw) bin/arm-linux-gnueabihf
	rm -rf bin/web
	cp -r src/maplinrobotarmweb/web/ bin

binaries := $(shell ls /usr/lib/*/libusb*.so* /lib/*/libusb*.so*)

copy-binaries:
	mkdir -p bin/$(triplet)
	mkdir -p lib/$(triplet)
	for b in $(binaries); do \
	    cp $$b bin/$(triplet)/; \
	    cp `ldd $$b | grep / | awk '{ print $$3}'` lib/$(triplet)/; \
	done

