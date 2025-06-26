#!/bin/sh

if [ -z "$1" ]; then
  docker pull jekyll/builder:pages
  docker run -it --rm \
    --workdir /srv/jekyll \
    --volume="$PWD:/srv/jekyll:Z" \
    --volume="$PWD/vendor/bundle:/usr/local/bundle:Z" \
    jekyll/builder:pages \
    ./build-in-docker.sh build
  zip -r site.zip _site
else
  chmod -R a+rwX /srv/jekyll
  bundle install --jobs=4
  bundle exec jekyll build
fi
