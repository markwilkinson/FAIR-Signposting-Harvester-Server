FROM ruby:3.0

ENV LANG="en_US.UTF-8" LANGUAGE="en_US:UTF-8" LC_ALL="C.UTF-8"
RUN chmod a+r /etc/resolv.conf

RUN mkdir /server
WORKDIR /server
RUN gem update --system
RUN gem install bundler:2.3.12
COPY . /server
RUN bundle install
WORKDIR /server/fsp-harvester-server
#CMD ["rerun", "'ruby /server/fsp-harvester-server/app/controllers/application_controller.rb  -o 0.0.0.0'"]
#CMD ["ruby", "./app/controllers/application_controller.rb",   "-o",  "0.0.0.0"]
