#!/usr/bin/env bash

bazel run //tools/pylint:pylint -- $(bazel info --show_make_env workspace)
