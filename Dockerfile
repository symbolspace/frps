FROM alpine

RUN apk add --update tzdata
ENV TZ=Asia/Shanghai

ENV FRP_VERSION 0.30.0
# wget https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz
RUN wget https://mirror-symbol.q32.top:8443/staticfile/software/github/releases/frp_${FRP_VERSION}_linux_amd64.tar.gz
RUN tar -xf frp_${FRP_VERSION}_linux_amd64.tar.gz
RUN mkdir /frps \
    && cp frp_${FRP_VERSION}_linux_amd64/frps* /frps/ \
    && rm -rf frp_${FRP_VERSION}_linux_amd64*

# Clean APK cache
RUN rm -rf /var/cache/apk/*

RUN mkdir /conf
VOLUME /conf

WORKDIR /frps
ENTRYPOINT ["./frps","-c","/conf/frps.ini"]
