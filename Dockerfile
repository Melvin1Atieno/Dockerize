FROM alpine:3.8

ENV BUILD_PACKAGES curl-dev ruby-dev build-base


# update and upgrade the manager repositories
RUN apk update && apk upgrade && apk add bash $BUILD_PACKAGES

# install ruby and ruby bundler
RUN apk add ruby ruby-io-console  ruby-bundler

#install gcc and g++ and make
RUN apk add gcc g++ make

#install jekyll and bundler gems
RUN gem install bundler -N 

#clean APK cache
RUN rm -rf /var/cache/apk/*


# create sites directory
WORKDIR /Zegetech-docker-version

#copy items into directory
COPY . /Zegetech-docker-version

#make port 4000 available
EXPOSE 4000

#install existing gems
RUN bundle install

ENTRYPOINT ["bundle","exec","jekyll","serve"]

#build site
CMD ["-H","0.0.0.0"]





