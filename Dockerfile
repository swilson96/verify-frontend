#FROM ruby:2.3.5
#FROM partlab/ubuntu-ruby
FROM     drecom/ubuntu-base:latest

# https://github.com/drecom/docker-ubuntu-ruby/blob/2.3.5/Dockerfile

RUN git clone git://github.com/rbenv/rbenv.git /usr/local/rbenv \
&&  git clone git://github.com/rbenv/ruby-build.git /usr/local/rbenv/plugins/ruby-build \
&&  git clone git://github.com/jf/rbenv-gemset.git /usr/local/rbenv/plugins/rbenv-gemset \
&&  /usr/local/rbenv/plugins/ruby-build/install.sh
ENV PATH /usr/local/rbenv/bin:$PATH
ENV RBENV_ROOT /usr/local/rbenv

RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh \
&&  echo 'export PATH=/usr/local/rbenv/bin:$PATH' >> /etc/profile.d/rbenv.sh \
&&  echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh

RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /root/.bashrc \
&&  echo 'export PATH=/usr/local/rbenv/bin:$PATH' >> /root/.bashrc \
&&  echo 'eval "$(rbenv init -)"' >> /root/.bashrc

ENV CONFIGURE_OPTS --disable-install-doc
ENV PATH /usr/local/rbenv/bin:/usr/local/rbenv/shims:$PATH

RUN eval "$(rbenv init -)"; rbenv install 2.3.5 \
&&  eval "$(rbenv init -)"; rbenv global 2.3.5 \
&&  eval "$(rbenv init -)"; gem update --system \
&&  eval "$(rbenv init -)"; gem install bundler

RUN apt-get update
RUN apt-get -y install xvfb

# Install firefox 47.0.1 for the rspec selenium tests.
# Inspired by https://www.askmetutorials.com/2016/06/install-firefox-47-on-ubuntu-1604-1404.html
RUN wget https://ftp.mozilla.org/pub/firefox/releases/47.0.1/linux-x86_64/en-GB/firefox-47.0.1.tar.bz2
RUN tar -xjf firefox-47.0.1.tar.bz2
RUN rm -rf /opt/firefox
RUN mv firefox /opt/firefox
RUN ln -s /opt/firefox/firefox /usr/bin/firefox
RUN export FIREFOX_PATH=/usr/bin/firefox

# Set the working directory to /app and mount the local file system there
VOLUME /app
WORKDIR /app

# ENTRYPOINT /bin/bash

# The main command to run.
CMD ["/bin/bash", "jenkins.sh"]

