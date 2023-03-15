# see docker-compose.yml

FROM ubuntu:22.04

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 python3-pip socat\
    && rm -rf /var/lib/apt/lists/
RUN pip3 install pycryptodome


WORKDIR /app

RUN useradd --create-home --shell /bin/bash ctf
WORKDIR /home/ctf

COPY vuln.py flag.txt /home/ctf/

#  # Permission
#  7 rwx
#  6 rw-
#  5 r-x
#  4 r--
#  3 -wx
#  2 -w-
#  1 --x
#  0 ---

# sane defaults
RUN chmod 555 /home/ctf && \
    chown -R root:root /home/ctf && \
    chmod -R 000 /home/ctf/*

RUN chmod 555 vuln.py && \
    chmod 444 flag.txt

RUN find / -ignore_readdir_race -type f \( -perm -4000 -o -perm -2000 \) -not -wholename /readflag -delete
USER ctf
RUN (find --version && id --version && sed --version && grep --version) > /dev/null
RUN ! find / -writable -or -user $(id -un) -or -group $(id -Gn|sed -e 's/ / -or -group /g') 2> /dev/null | grep -Ev -m 1 '^(/dev/|/run/|/proc/|/sys/|/tmp|/var/tmp|/var/lock|/var/mail|/var/spool/mail)'

EXPOSE 1024
CMD socat TCP-LISTEN:1024,reuseaddr,fork EXEC:"python3 vuln.py"

