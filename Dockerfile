FROM openjdk:8u265-jre-slim-buster
ENV LANG C.UTF-8
WORKDIR /workdir
RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends ca-certificates dirmngr gnupg wget; \
	apt-get clean; \
	rm -rf /var/lib/apt/lists/*; 
RUN wget https://github.com/yyuueexxiinngg/cqhttp-mirai/releases/download/0.2.1/cqhttp-mirai-0.2.1-embedded-all.jar -O cqhttp-mirai.jar
ADD device.json.example device.json
ADD config.txt.example config.txt
ADD setting.yml.example plugins/setting.yml
COPY *.sh ./
ENTRYPOINT ["/bin/sh", "entry.sh"]
