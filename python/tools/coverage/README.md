# Coverage

## Description

* Bazel does not support test coverage for python tests natively.
* Therefore this is a workaround to get results of python files coverage locally.
* This solution is not suitable for the CI.

## Steps

1. You need to load the `pycoverage` rules in the `BUILD` file of the tests:

`load("//tools/coverage:pycoverage.bzl", "pycoverage")`

2. And then add the `pycoverage` target with a dependency on the tests it's doing the coverage for:

```bash
pycoverage(
    name = "pycoverage",
    deps = [":test_target"],
)
```

Complete example:

```bash
load("@rules_python//python:defs.bzl", "py_test")
load("//tools/coverage:pycoverage.bzl", "pycoverage")

py_test(
    name = "singleton_meta_test",
    srcs = ["singleton_meta_test.py"],
    deps = ["//utils:singleton"],
)

pycoverage(
    name = "singleton_coverage",
    deps = [
        ":singleton_meta_test",
    ],
)

```

3. Then you can run the coverage target with: `bazel test --test_output=all --spawn_strategy=local --nocache_test_results //utils/test:pycoverage`.

Only when using `spawn_strategy local`, the reports are available. Wildcards do intentionally not work.

4. You can open the coverage `html` file by then running the script with the same name as the target name specified in the `BUILD` file: `./tools/coverage/find_target.sh TARGET_NAME`, for example:

```bash
./tools/coverage/find_target.sh singleton_coverage
```

---

To fetch all pycoverage targets, one can execute:

```bash
bazel query 'attr(tags, pycoverage, tests(//...))'
```

One can also combine both commands such that all pycoverage targets are being executed

```bash
bazel test $(bazel query 'attr(tags, pycoverage, tests(//...))') --test_output all --spawn_strategy local
```

*Note*:
Do not commit the `pycoverage` target! This solution is intended for local checks only.

[bazelbuild/bazel/issues/10660](https://github.com/bazelbuild/bazel/issues/10660)
