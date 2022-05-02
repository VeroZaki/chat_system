FROM ruby:3.1.2

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /chat_system
WORKDIR /chat_system

ADD Gemfile /chat_system/Gemfile
ADD Gemfile.lock /chat_system/Gemfile.lock

RUN bundle install

ADD . /chat_system