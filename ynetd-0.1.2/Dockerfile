FROM debian:bullseye AS build

COPY . .

RUN apt-get update && apt-get install -y \
  build-essential \
  libssl-dev \
  libpam0g-dev \
  libwrap0-dev \
  libcap-dev \
  libsystemd-dev \
  libpam-systemd \
  libpam-cap \
  libpam-modules \
  libpam-modules-bin \
  libpam-runtime \
  libpam0g \
  libwrap0 \
  libcap2-bin \
  libcap2 \
  libsystemd0 \
  libsystemd-dev \
  libsystemd0

RUN make

FROM debian:bullseye AS runtime

COPY --from=build /ynetd /sbin/ynetd
RUN chmod +x /sbin/ynetd

RUN apt-get update && apt-get install -y \
  libpam0g \
  libwrap0 \
  libcap2 \
  libsystemd0


