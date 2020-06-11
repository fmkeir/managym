FROM ruby:2.7

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY start.sh .
RUN chmod +x start.sh

COPY . .

ENTRYPOINT ["bash", "start.sh"]