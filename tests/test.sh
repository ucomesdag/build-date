#!/bin/sh

test() {
  type="${1}"
  file="${2}"
  label="${3}"
  format="${4}"

  cd "${type}"
  result=$(../../${type}.sh)
  if $result
  then
    build_date=$(grep "$label" "$file" | sed "s/^.*${label}=\"\(.*\)\"$/\1/")
    reference_date=$(date $format -d $build_date)
    if [ "$reference_date" != "$build_date" ]
    then
      echo "${type} returned an incorrect date format."
    fi
  else
    echo "${type} failed."
    return 1
  fi
    
  cd ../
}

# This runs the tests and validates the result.
test container_build_date Containerfile build_date "+%Y-%m-%dT%H:%M:%S%Z"
