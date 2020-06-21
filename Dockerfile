FROM ruby:2.7.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn
RUN mkdir /app
WORKDIR /app
RUN gem install bundler
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install

ADD . /app

ENTRYPOINT ["bin/entrypoint.sh"]

EXPOSE 3000

CMD ["./bin/entrypoint.sh"]
