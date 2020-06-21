FROM ruby:2.6.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs-current nodejs-npm yarn
RUN mkdir /app
WORKDIR /app
RUN gem install bundler
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install

COPY package.json yarn.lock .postcssrc.yml ./
RUN yarn install

ADD . /app

ENTRYPOINT ["bin/entrypoint.sh"]

EXPOSE 3000

CMD ["./bin/entrypoint.sh"]
