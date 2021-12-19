#!/bin/sh

# A script to find update the build_date label in a Containerfile.

if [[ $OSTYPE == 'darwin'* ]]; then
  alias date='gdate'
  dependencies='sed gdate find'
else
  dependencies='sed date find'
fi

for binary in sed date find; do
  which "${binary}" > /dev/null 2>&1 || (echo "Missing ${binary}, please install it." ; exit 1)
done

builddate() {
  builddate=$(grep build_date "${1}" | sed "s/^.*build_date=\"\(.*\)\"$/\1/")
  timestamp="$(date +%Y-%m-%dT%H:%M:%S%Z)"
  let diff=($(date +%s -d $timestamp)-$(date +%s -d $builddate))
  if [ $diff -gt $(expr 3600 \* 3) ]
  then
    sed -i "s/^\(LABEL\s\+build_date=\).*$/\1\"${timestamp}\"/" "${1}"
  fi
}

for file in $(find ./ -maxdepth 1 -name Containerfile) ; do
  builddate ${file}
done
