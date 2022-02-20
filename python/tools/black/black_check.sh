#!/usr/bin/env bash

bazel run //tools/black:black_check -- $(pwd)
