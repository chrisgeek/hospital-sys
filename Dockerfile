FROM ruby:2.5.1

# NodeJs
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs

# copy to application dir
COPY . /application

# change to /application dir
WORKDIR /application

# install gems
RUN gem install bundler -v 2.0.1
RUN bundle install --deployment --without development test

# Set Rails environment to production
ENV RAILS_ENV production

ENTRYPOINT ./entrypoint.sh
