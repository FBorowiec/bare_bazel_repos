#!/usr/bin/env bash

if [ $# -eq 0 ]
  then
    echo "No target specified! Please provide the coverage target name (ex. trade_node_cov - specified in the BUILD file)"
    exit 1
fi

xdg-open $(find $(bazel info execution_root) -regextype posix-extended -regex "^.*\/test\/.*$1\.runfiles\/.*\/pycoverage_html\/index.html$")
