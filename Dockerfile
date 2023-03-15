FROM debian:bullseye
# ARG로 buildx 빌드 시에 ARCH를 받아옵니다.
ARG TARGETARCH

# 아키텍쳐의 따라 ynetd-amd64 또는 ynetd-arm를 사용해야 합니다.
COPY ynetd-binary/ynetd-${TARGETARCH} /sbin/ynetd

RUN echo ${TARGETARCH}

# 쉘 스크립트를 실행할 수 있도록 권한을 부여합니다.
RUN chmod +x /sbin/ynetd