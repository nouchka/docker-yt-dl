DOCKER_IMAGE=yt-dl

include Makefile.docker

PACKAGE_VERSION=0.1

include Makefile.package

.PHONY: check-version
check-version:
	docker run --rm $(DOCKER_NAMESPACE)/$(DOCKER_IMAGE):latest --version

.PHONY: deb
deb:
	mkdir -p build/usr/sbin/
	cp -Rf bin/* build/usr/sbin/

.PHONY: run
run:
	./bin/$(DOCKER_IMAGE)

install:
	install bin/yt-dl $(prefix)/bin
	install bin/yt-mp3 $(prefix)/bin
