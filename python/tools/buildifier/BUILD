load("@com_github_bazelbuild_buildtools//buildifier:def.bzl", "buildifier")

package(default_visibility = ["//visibility:public"])

buildifier(
    name = "buildifier",
)

buildifier(
    name = "buildifier_check",
    lint_mode = "warn",
    mode = "check",
)
