# see docker-compose.yml

FROM ubuntu:22.04

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    make g++ libntl-dev socat \
    && rm -rf /var/lib/apt/lists/

RUN useradd --create-home --shell /bin/bash ctf
WORKDIR /home/ctf

COPY Makefile vuln.cpp crypto_sign.tar.gz flag.txt /home/ctf/

USER ctf
RUN make
USER root

# sane defaults
RUN chmod 555 /home/ctf && \
    chown -R root:root /home/ctf && \
    chmod -R 000 /home/ctf/*

RUN chmod 555 vuln && \
    chmod 444 description && \
    chmod 444 flag.txt

# check whitelist of writable files/folders
RUN find / -ignore_readdir_race -type f \( -perm -4000 -o -perm -2000 \) -not -wholename /readflag -delete
USER ctf
RUN (find --version && id --version && sed --version && grep --version) > /dev/null
RUN ! find / -writable -or -user $(id -un) -or -group $(id -Gn|sed -e 's/ / -or -group /g') 2> /dev/null | grep -Ev -m 1 '^(/dev/|/run/|/proc/|/sys/|/tmp|/var/tmp|/var/lock|/var/mail|/var/spool/mail)'
USER root

# EXPOSE all your ports
EXPOSE 1024
CMD socat TCP-LISTEN:1024,reuseaddr,fork EXEC:"./vuln"