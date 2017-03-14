FROM alpine:latest

ENV VERSION 2016.11.3
ENV TARBALL_BASE salt-${VERSION}
ENV TARBALL https://github.com/saltstack/salt/archive/v${VERSION}.tar.gz
RUN apk --update --update-cache upgrade \
    && apk add --no-cache \
        py-pip \
        python-dev \
        ca-certificates \
        swig \
        openssl \
        gcc \
        g++ \
        libc-dev \
    && update-ca-certificates \
    && pip install --upgrade pip
RUN wget ${TARBALL} \
    && tar xzf v${VERSION}.tar.gz \
    && pip install ./${TARBALL_BASE}/ \
    && rm v${VERSION}.tar.gz

# 4505 = Salt Pub ; 4506 = Salt Req
EXPOSE 4505 4506

CMD /usr/bin/salt-master -d
