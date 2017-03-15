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
    && rm -rf v${VERSION}.tar.gz \
    && rm -rf salt-${VERSION}
RUN mkdir /etc/salt \
    && mkdir /etc/salt/master.d \
    && mkdir /etc/salt/minion.d \
    && mkdir -p /srv/salt/base

COPY roots.conf /etc/salt/master.d/
COPY master.conf /etc/salt/minion.d/

# 4505 = Salt Pub ; 4506 = Salt Req
EXPOSE 4505 4506

CMD /usr/bin/salt-master -d  
