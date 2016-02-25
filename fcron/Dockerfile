FROM alpine:edge
RUN apk add --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
  --update fcron \
&& apk add --repository http://dl-3.alpinelinux.org/alpine/edge/community/ \
  --update docker \
&& rm -rf /var/cache/apk/*
ADD 
ENTRYPOINT ["/usr/sbin/fcron","-f","-y"]
