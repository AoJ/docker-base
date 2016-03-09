FROM alpine:3.3
MAINTAINER AooJ <aooj@n13.cz>

# better init system. Yes, it's necessary 
# correct forward signals (INT, TERM, HUP and job control)
# and check for zombie process and re-attach it to itself
# I don't like zooooooombie procceses!
RUN apk add --no-cache --update                                           \
    --repository http://dl-4.alpinelinux.org/alpine/edge/community/ tini  \
    && echo '#!/usr/bin/env sh' > /run/start.sh                           \
    && echo 'exec $@' >> /run/start.sh                                    \
    && chmod +x /run/start.sh                                             \
    && rm -rf /var/cache/apk/*

CMD sh
ENTRYPOINT ["/usr/bin/tini", "-g", "--", "/run/start.sh"]
