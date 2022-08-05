FROM ruby:3.0

ENV LANG="en_US.UTF-8" LANGUAGE="en_US:UTF-8" LC_ALL="C.UTF-8"
RUN chmod a+r /etc/resolv.conf

RUN mkdir /fsp-harvester-server
WORKDIR /fsp-harvester-server
RUN gem update --system
RUN gem install bundler:2.2.28
COPY . /fsp-harvester-server/
RUN bundle install
CMD ["rerun", "'ruby ./app/controllers/application_controller.rb  -o 0.0.0.0'"]
