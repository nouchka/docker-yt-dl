DOCKER_IMAGE=yt-dl

include Makefile.docker

PACKAGE_VERSION=0.1

include Makefile.package

.PHONY: check-version
check-version:
	docker run --rm $(DOCKER_NAMESPACE)/$(DOCKER_IMAGE):latest --version

install:
	install bin/yt-dl $(prefix)/bin
	install bin/yt-mp3 $(prefix)/bin
