FROM ruby:2.3.5

RUN apt-get update
RUN apt-get -y install xvfb

# Set the working directory to /app and mount the local file system there
VOLUME /app
WORKDIR /app

# ENTRYPOINT /bin/bash

# The main command to run.
CMD ["/bin/bash", "jenkins.sh"]

