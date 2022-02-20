load("@rules_python//python:defs.bzl", "py_binary")

package(default_visibility = ["//visibility:public"])

filegroup(
    name = "pylintrc",
    srcs = [".pylintrc"],
)

py_binary(
    name = "pylint",
    srcs = ["pylint_run.py"],
    data = [":pylintrc"],
    main = "pylint_run.py",
    deps = ["//third_party:pylint"],
)
