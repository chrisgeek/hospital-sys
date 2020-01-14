FROM ruby:2.5.1

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs postgresql-client

# copy app
RUN mkdir /hospital-sys
WORKDIR /hospital-sys

COPY Gemfile /hospital-sys/Gemfile
COPY Gemfile.lock /hospital-sys/Gemfile.lock

# update gems
# RUN bundle install --full-index
# RUN gem update --system && gem update bundler
RUN bundle install --full-index

COPY . /hospital-sys

# Add script to be executed every time the container starts
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]


# EXPOSE 3000
EXPOSE 80

# Start the main process
CMD ["rails", "server", "-b", "0.0.0.0"]
