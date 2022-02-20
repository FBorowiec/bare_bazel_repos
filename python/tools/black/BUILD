load("@rules_python//python:defs.bzl", "py_binary")

package(default_visibility = ["//visibility:public"])

py_binary(
    name = "black",
    srcs = ["black_run.py"],
    main = "black_run.py",
    deps = ["//third_party:black"],
)

py_binary(
    name = "black_check",
    srcs = ["black_run.py"],
    args = ["--check --diff"],
    main = "black_run.py",
    deps = ["//third_party:black"],
)
