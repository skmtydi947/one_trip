FROM ruby:2.6.4
RUN apt-get update -qq&& apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /One_Trip
WORKDIR /One_Trip
ADD Gemfile /One_Trip/Gemfile
ADD Gemfile.lock /One_Trip/Gemfile.lock
ENV BUNDLER_VERSION=2.0.2
RUN gem install bundler -v "$BUNDLER_VERSION" && bundle install
ADD . /One_Trip