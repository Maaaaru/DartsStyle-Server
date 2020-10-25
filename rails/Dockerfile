FROM node:14.14-alpine as node

RUN apk add --no-cache bash curl && \
    curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version 1.22.5

FROM ruby:2.7-alpine3.12

ENV APP_ROOT /app

RUN mkdir $APP_ROOT

WORKDIR $APP_ROOT

COPY --from=node /usr/local/bin/node /usr/local/bin/node
COPY --from=node /opt/yarn-* /opt/yarn

RUN ln -fs /opt/yarn/bin/yarn /usr/local/bin/yarn && \
    apk update && \
    apk add --no-cache git \
    tzdata \
    libxml2-dev \
    make \
    gcc \
    libc-dev \
    g++ \
    postgresql-dev \
    postgresql-client \
    imagemagick \
    bash \
    build-base \
    curl-dev

COPY Gemfile $APP_ROOT/Gemfile
COPY Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle update --bundler
RUN bundle install

COPY . $APP_ROOT

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]