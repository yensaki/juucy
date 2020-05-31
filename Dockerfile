FROM ruby:2.6.2

RUN apt-get update && \
    apt-get install -y \
#    build-essential \
    nodejs \
    mysql-client

ENV APP_HOME /app
WORKDIR $APP_HOME

RUN gem update --system && \
    gem install bundler

ADD Gemfile Gemfile.lock $APP_HOME/

RUN bundle install --jobs=4 --retry=5

COPY . $APP_HOME

EXPOSE $PORT

CMD "bundle exec rails server -p #{$PORT}"
