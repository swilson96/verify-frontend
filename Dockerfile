# Matches the version in .ruby-version
FROM ruby:2.3.5

# Set the working directory to /app and mount the local file system there
VOLUME /app
WORKDIR /app

# The main command to run.
CMD ["/bin/bash", "jenkins.sh"]

