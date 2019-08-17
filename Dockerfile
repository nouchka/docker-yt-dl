FROM debian:stable-slim
LABEL maintainer="Jean-Avit Promis docker@katagena.com"

ARG VERSION=2019.08.13
ARG FILE_SHA256SUM=b23d59df96f9dccf34d9c48b65e7bc93532f1ebc4bf71b9285f228bc6086242d
ENV FILE_URL https://yt-dl.org/downloads/latest/youtube-dl-${VERSION}.tar.gz

COPY start.sh /start.sh
COPY playlist.sh /playlist.sh

RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get -yq install wget python rsync default-mysql-client cron procps ffmpeg && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	wget -qO- "${FILE_URL}" > /tmp/archive.tgz && \
	sha256sum /tmp/archive.tgz && \
	echo "${FILE_SHA256SUM}  /tmp/archive.tgz"| sha256sum -c - && \
	tar xzf - -C / < /tmp/archive.tgz && \
	mv youtube-dl /usr/local/bin/ && \
	chmod a+x /usr/local/bin/youtube-dl && \
	chmod +x /start.sh && \
	chmod +x /playlist.sh

ENV YOUTUBE_ID k7J3E8KkgaM
##Ed Pratt
##Cyclotron
ENV YOUTUBE_PLAYLIST UCuNy42Y5egf07cSiHbF23wg UCA9QYuUcPGYbbXPqkSDSd3g
ENV YOUTUBE_DIRECTORY /data

VOLUME ${YOUTUBE_DIRECTORY}
WORKDIR ${YOUTUBE_DIRECTORY}

ENTRYPOINT ["/bin/bash", "-e", "/start.sh"]
