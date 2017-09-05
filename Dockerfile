FROM debian:jessie
MAINTAINER Jean-Avit Promis "docker@katagena.com"

RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get -yq install wget python rsync mysql-client && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget https://yt-dl.org/latest/youtube-dl -O /usr/local/bin/youtube-dl && \
	chmod a+x /usr/local/bin/youtube-dl

COPY start.sh /start.sh
RUN chmod +x /start.sh

ENV YOUTUBE_ID k7J3E8KkgaM

CMD ["/bin/bash", "-e", "/start.sh"]
