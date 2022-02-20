"""This module defines the rule for python coverage"""

load("@rules_python//python:defs.bzl", "py_test")

pycoverage_requirements = [
    "//third_party:coverage",
]

def pycoverage(name = None, deps = None, tags = None, timeout = "short"):
    """Python Coverage Rule.

    One must explicitly name the target to be executed.
    Examples:
        Query for all pycoverage targets:
            bazel query 'attr(tags, pycoverage, tests(//...))'
        Run single target:
            bazel test //path/to:target

    Args:
        name (str): The optional name of this rule, default: "_coverage"
        deps (list): A list of dependencies to the test target(s) to measure coverage
        tags (list): A list of tags, the default tags "pycoverage" and "manual" always gets added
        timeout (str): Bazel timeout string, default to short, can be overwritten in the pycoverage target
    """
    if not name:
        fail("You need to specify a name for this target")
    if not deps:
        fail("You need to specify at least one dependency to a test target")

    py_test(
        name = name,
        main = "pycoverage_run.py",
        srcs = ["//tools/coverage:pycoverage_run"],
        imports = ["."],
        args = [],
        data = [],
        deps = depset(direct = deps + pycoverage_requirements).to_list(),
        timeout = timeout,
        tags = tags,
    )
