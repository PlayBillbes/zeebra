FROM v2ray/official

ENV TTY_VER 1.6.1

RUN apt-get -y update && \
    apt-get install -y curl && \
    curl -sLk https://github.com/tsl0922/ttyd/releases/download/${TTY_VER}/ttyd_linux.x86_64 -o ttyd_linux && \
    chmod +x ttyd_linux && \
    cp ttyd_linux /usr/local/bin/

RUN echo 'Installing additional packages...' && \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get update && \
	apt-get install \
	sudo \
	wget \
        unzip \
	screen \
	-y --show-progress 
RUN wget -O temp.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip
RUN unzip temp.zip
RUN rm -f temp.zip
RUN mv v2ray web
COPY vss.sh /vss.sh
RUN chmod 744 /vss.sh
CMD ["/bin/bash","/vss.sh"]
EXPOSE 8000
