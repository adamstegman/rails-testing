FROM ubuntu:14.04
MAINTAINER Adam Stegman <astegman@gmail.com>

RUN apt-get -y update; \
    apt-get -y install wget

# Install Ruby 2.1.4
RUN apt-get -y install \
      git-core curl zlib1g-dev build-essential python-software-properties \
      libssl-dev libreadline-dev libyaml-dev libffi-dev libcurl4-openssl-dev
RUN cd /tmp; \
    wget http://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.4.tar.gz; \
    tar xf ruby-2.1.4.tar.gz; \
    cd ruby-2.1.4; \
    ./configure; \
    make; \
    make install
RUN gem install bundler --no-ri --no-rdoc

# Install Node
RUN cd /tmp; \
    wget http://nodejs.org/dist/v0.12.4/node-v0.12.4-linux-x64.tar.gz; \
    tar xf node-v0.12.4-linux-x64.tar.gz; \
    mv node-v0.12.4-linux-x64 /usr/local; \
    ln -s /usr/local/node-v0.12.4-linux-x64/bin/node /usr/local/bin/node; \
    ln -s /usr/local/node-v0.12.4-linux-x64/bin/npm /usr/local/bin/npm

# Install app native dependencies for:
# * MySQL
# * Nokogiri
# * capybara-webkit
# * memcached
RUN apt-get -y install libmysqlclient-dev \
      libxml2-dev libxslt1-dev \
      qt5-default libqt5webkit5-dev g++ \
      memcached

# Clean up the image
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
