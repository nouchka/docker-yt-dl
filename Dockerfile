FROM debian:stable-slim
LABEL maintainer="Jean-Avit Promis docker@katagena.com"

ARG VERSION=2021.03.14
ARG FILE_SHA256SUM=3595d61a08966b940681842f002cff93e9199dbe1f280775d956762f8fe6b927
ENV FILE_URL https://yt-dl.org/downloads/${VERSION}/youtube-dl

COPY start.sh /start.sh
COPY playlist.sh /playlist.sh

RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get -yq install wget python rsync default-mysql-client cron procps ffmpeg && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	wget "${FILE_URL}" -O /usr/local/bin/youtube-dl && \
	sha256sum /usr/local/bin/youtube-dl && \
	echo "${FILE_SHA256SUM}  /usr/local/bin/youtube-dl"| sha256sum -c - && \
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

ENTRYPOINT ["/usr/local/bin/youtube-dl"]
