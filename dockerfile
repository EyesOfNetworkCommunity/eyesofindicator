FROM ruby:alpine

MAINTAINER "Jean-Philippe Levy <jean-philippe.levy@axians.com>"

RUN apk update && apk upgrade \
    && apk add tzdata curl wget bash nodejs

# Needed to make native extensions 
RUN apk add  g++ musl-dev make \
    && echo "gem: --no-document" > /etc/gemrc \
    && gem install bundler json \
    && gem install smashing

# Create dashboard and link volumes
RUN smashing new eoi

WORKDIR /eoi

RUN cd /eoi \
    && bundle \
    && ln -s /eoi/dashboards /dashboards \
    && ln -s /eoi/jobs /jobs \
    && ln -s /eoi/assets /assets \
    && ln -s /eoi/lib /lib-eoi \
    && ln -s /eoi/public /public \
    && ln -s /eoi/widgets /widgets \
    && mkdir /eoi/config \
    && mv /eoi/config.ru /eoi/config/config.ru \
    && ln -s /eoi/config/config.ru /eoi/config.ru \
    && ln -s /eoi/config /config \
    && rm -rf /var/cache/apk/*

COPY run.sh /

VOLUME ["/dashboards", "/jobs", "/lib-eoi", "/config", "/public", "/widgets", "/assets"]

ENV PORT 3030
EXPOSE ${PORT}
WORKDIR /eoi

CMD ["/run.sh"]
