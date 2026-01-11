FROM alpine:3.22 AS builder

WORKDIR /build

RUN apk update
RUN apk upgrade
RUN apk add --no-cache alpine-sdk linux-headers git zlib-dev openssl-dev gperf cmake
RUN git clone --recursive https://github.com/tdlib/telegram-bot-api.git
RUN \
   cd telegram-bot-api && \
   mkdir build && cd build && \
   cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=.. .. && \
   cmake --build . --target install --parallel "$(nproc)"

FROM ghcr.io/alkk/baseimage:latest

RUN apk add --no-cache libstdc++

ENV TIME_ZONE=Europe/Riga

WORKDIR /srv

EXPOSE 8081/tcp

COPY --from=builder /build/telegram-bot-api/bin/telegram-bot-api /srv/
COPY start.sh /srv/

CMD ["/srv/start.sh"]
