FROM ubuntu:22.04 AS build

COPY . .

RUN apt-get update && apt-get install -y \
  build-essential

RUN make

FROM ubuntu:22.04 AS runtime

COPY --from=build /ynetd /sbin/ynetd
RUN chmod +x /sbin/ynetd