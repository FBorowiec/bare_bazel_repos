import logging
import unittest
import sys
import collections
import coverage

PycoverageResult = collections.namedtuple("PycoverageResult", "runs errors failures")
omited_files = ["*/external/*", "*__init__.py", "/usr/lib/*", "*/lib/python3*", "*_test.py"]


def invoke_coverage(start_dir=".", pattern="*test*.py"):
    cov = coverage.Coverage(branch=True, omit=omited_files)
    cov.start()

    loader = unittest.TestLoader()
    all_tests_suite = loader.discover(start_dir, pattern=pattern)

    runner = unittest.TextTestRunner()
    result = runner.run(all_tests_suite)

    cov.stop()
    cov.save()

    try:
        cov.html_report(directory="pycoverage_html")
        cov.xml_report(outfile="pycoverage.xml")
    except coverage.misc.CoverageException:
        logging.error(" NO COVERAGE AVAILABLE FOR THE SPECIFIED TARGET")
        sys.exit(1)

    pycoverage_results = PycoverageResult(
        runs=result.testsRun, errors=len(result.errors), failures=len(result.failures)
    )

    cov.report()

    if len(result.failures) > 0:
        logging.error("AT LEAST ONE TEST FAILED")
        sys.exit(1)

    return cov, pycoverage_results


if __name__ == "__main__":
    invoke_coverage()
