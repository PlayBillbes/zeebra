FROM alpine:edge
ENV TTY_VER 1.6.1
#ENV USER kali
#ENV PASSWORD kali

RUN apk update && \
    apk add curl && \
    curl -sLk https://github.com/tsl0922/ttyd/releases/download/${TTY_VER}/ttyd_linux.x86_64 -o ttyd_linux && \
    chmod +x ttyd_linux && \
    cp ttyd_linux /usr/local/bin/

RUN echo 'Installing additional packages...' && \
	export DEBIAN_FRONTEND=noninteractive && \
	apk update && \
	apk add --no-cache tini bash sudo nano unzip 
	
COPY vss.sh /vss.sh
RUN chmod 744 /vss.sh
COPY run.sh /run.sh
RUN chmod 744 /run.sh
COPY relay.sh /relay.sh
RUN chmod 744 /relay.sh
RUN ./relay.sh 
RUN relay login -k ce10e352-5cf9-4c4d-b0b7-a9834f7b74b1 -s k74jiYF1Kzo2

CMD [/run.sh"]
