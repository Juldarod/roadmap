FROM ruby:2.6.3

RUN apt-get install curl -y \
    && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get install nodejs -y \
    && npm i -g yarn
WORKDIR /user/app
COPY ./ ./
RUN bundle install
COPY ./ ./
RUN rake secret \
    && bin/setup \
    && rake webpacker:yarn_install
COPY ./ ./
EXPOSE 3000

# CMD ["rails", "server"]