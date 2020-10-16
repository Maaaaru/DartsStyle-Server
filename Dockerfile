FROM ruby:2.7.1-alpaine

RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

COPY gemfile $APP_ROOT/Gemfile
COPY gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle update --bundler
RUN bundle install

COPY . $APP_ROOT

COPY entrypoint.sh usr/bin/
RUN chmod +x usr/bin/entrypoint.sh
ENTRYPOINT [ "entrypoint.sh" ]
EXPOSE 3000