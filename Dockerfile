FROM debian:stable-slim
MAINTAINER Jean-Avit Promis "docker@katagena.com"

RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get -yq install wget python rsync mysql-client cron && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget https://yt-dl.org/latest/youtube-dl -O /usr/local/bin/youtube-dl && \
	chmod a+x /usr/local/bin/youtube-dl

COPY start.sh /start.sh
RUN chmod +x /start.sh

COPY playlist.sh /playlist.sh
RUN chmod +x /playlist.sh

ENV YOUTUBE_ID k7J3E8KkgaM
##Ed Pratt
##Cyclotron
ENV YOUTUBE_PLAYLIST UCuNy42Y5egf07cSiHbF23wg UCA9QYuUcPGYbbXPqkSDSd3g
ENV YOUTUBE_DIRECTORY /data

VOLUME /data

ENTRYPOINT ["/bin/bash", "-e", "/start.sh"]
