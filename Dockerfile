FROM ruby:3.0

ENV LANG="en_US.UTF-8" LANGUAGE="en_US:UTF-8" LC_ALL="C.UTF-8"
RUN chmod a+r /etc/resolv.conf

RUN apt-get dist-upgrade -q && \
    apt-get update -q
#RUN apt-get update -q
RUN apt-get install -y --no-install-recommends build-essential lighttpd && \
  apt-get install -y --no-install-recommends libxml++2.6-dev  libraptor2-0 && \
  apt-get install -y --no-install-recommends libxslt1-dev locales software-properties-common cron && \
  apt-get clean
  
RUN mkdir /server
WORKDIR /server
RUN gem update --system
RUN gem install bundler:2.3.12
COPY . /server
RUN bundle install
WORKDIR /server/fsp-harvester-server
#CMD ["rerun", "'ruby /server/fsp-harvester-server/app/controllers/application_controller.rb  -o 0.0.0.0'"]
#CMD ["ruby", "./app/controllers/application_controller.rb",   "-o",  "0.0.0.0"]
