FROM node:12.4.0-alpine as node
RUN cp -r /opt/yarn-v$(yarn --version)/ /opt/yarn/

FROM ruby:2.6.6 as main
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn
RUN mkdir /app
WORKDIR /app
RUN gem install bundler

COPY --from=node /opt/yarn /opt/yarn
COPY --from=node /usr/local/bin/node /usr/local/bin/
RUN ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn \
    && ln -s /opt/yarn/bin/yarnpkg /usr/local/bin/yarnpkg

ADD Gemfile /app
ADD Gemfile.lock /app
RUN bundle install

ADD package.json yarn.lock webpack.config.js /app/
RUN yarn install
ADD frontend /app/frontend
ADD public /app/public
RUN yarn run webpack

ADD . /app

EXPOSE 3000

CMD ["./bin/entrypoint.sh"]
