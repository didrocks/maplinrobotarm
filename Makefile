machine := $(shell uname -m)

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
	mkdir -p bin/$(triplet)
	mv $(mra) $(mraw) bin/$(triplet)
	mkdir -p bin/$(triplet)/web
	cp -r src/maplinrobotarmweb/web/ bin/

binaries := $(shell ls /usr/lib/*/libusb*.so*)

copy-binaries:
	mkdir -p bin/$(triplet)
	mkdir -p lib/$(triplet)
	for b in $(binaries); do \
	    cp $$b bin/$(triplet)/; \
	    cp `ldd $$b | grep / | awk '{ print $$3}'` lib/$(triplet)/; \
	done

