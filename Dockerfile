FROM ruby:3.0.2

# set env
ENV LANG ja_JP.UTF-8

# set yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# install libraries
RUN apt-get update -qq && \
  apt-get install -y \
  locales \
  locales-all \
  nodejs \
  postgresql-client \
  yarn && \
  apt-get clean && \
  rm --recursive --force /var/lib/apt/lists/*

# set working directory
RUN mkdir /app
ENV APP_ROOT /app
WORKDIR $APP_ROOT

# bundle install
ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock
RUN bundle install --jobs 4

COPY . $APP_ROOT

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]