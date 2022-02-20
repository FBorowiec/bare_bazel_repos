load("@rules_python//python:defs.bzl", "py_library")

package(default_visibility = ["//visibility:public"])

filegroup(
    name = "pycoverage_run",
    srcs = ["pycoverage_run.py"],
)

py_library(
    name = "pycoverage",
    srcs = ["pycoverage_run.py"],
    deps = ["//third_party:coverage"],
)
