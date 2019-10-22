FROM ruby:2.6.2

RUN apt-get update && \
    apt-get install -y \
#    build-essential \
    nodejs \
    mysql-client

RUN gem update --system && \
    gem install bundler

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile $APP_HOME/Gemfile
ADD Gemfile.lock $APP_HOME/Gemfile.lock
#ENV BUNDLE_PATH $APP_HOME/vendor/bundle
#ENV BUNDLE_APP_CONFIG $APP_HOME/.bundle
#RUN mkdir $APP_HOME/.bundle
#COPY .bundle/config $APP_HOME/.bundle/config
RUN bundle install --jobs=4 --retry=5

#COPY . $APP_HOME
COPY app $APP_HOME
COPY bin $APP_HOME
COPY config $APP_HOME
COPY db $APP_HOME
COPY lib $APP_HOME
COPY public $APP_HOME
COPY package.json $APP_HOME

EXPOSE 3000

CMD bundle exec rails s
