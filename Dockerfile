FROM debian:jessie
MAINTAINER Oleg Morozenkov

RUN rm /etc/apt/sources.list && \
	echo "deb [check-valid-until=no] http://archive.debian.org/debian-security jessie/updates main" >> /etc/apt/sources.list.d/jessie.list && \
	echo "deb [check-valid-until=no] http://archive.debian.org/debian jessie main" >> /etc/apt/sources.list.d/jessie.list

RUN apt-get update && \
	apt-get install -y --force-yes uwsgi-plugin-php php5-curl php5-json && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

COPY uwsgi.conf /etc/uwsgi.conf

EXPOSE 80
CMD ["uwsgi", "--ini", "/etc/uwsgi.conf"]
