#!/bin/sh

if [ -z "$1" ]; then
  docker pull jekyll/builder:pages
  docker run -it --rm \
    --workdir /srv/jekyll \
    --volume="$PWD:/srv/jekyll:Z" \
    --volume="$PWD/vendor/bundle:/usr/local/bundle:Z" \
    --publish 7654:7654 \
    --publish 5001:5001 \
    jekyll/builder:pages \
    ./build-in-docker.sh build
else
  bundle install --jobs=4
  bundle exec jekyll serve \
    -H 0.0.0.0 \
    --port 7654 \
    --trace \
    --watch \
    --force_polling \
    --incremental \
    --livereload \
    --livereload-port 5001
fi
