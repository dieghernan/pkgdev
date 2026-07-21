

<!-- README.md is generated from README.qmd. Please edit that file -->

# pkgdev <a href='https://dieghernan.github.io/pkgdev/'><img src="man/figures/logo.png" align="right" height="139"/></a>

<!-- badges: start -->

[![R-CMD-check](https://github.com/dieghernan/pkgdev/actions/workflows/check-full.yaml/badge.svg)](https://github.com/dieghernan/pkgdev/actions/workflows/check-full.yaml)
[![r-universe](https://dieghernan.r-universe.dev/badges/pkgdev)](https://dieghernan.r-universe.dev/)
[![CodeFactor](https://www.codefactor.io/repository/github/dieghernan/pkgdev/badge)](https://www.codefactor.io/repository/github/dieghernan/pkgdev)
[![codecov](https://codecov.io/gh/dieghernan/pkgdev/graph/badge.svg?token=QsBsMNjzXN)](https://codecov.io/gh/dieghernan/pkgdev)
[![Coverage
Status](https://coveralls.io/repos/github/dieghernan/pkgdev/badge.svg?branch=main)](https://coveralls.io/github/dieghernan/pkgdev?branch=main)
[![Project Status: Concept – Minimal or no implementation has been done
yet, or the repository is only intended to be a limited example, demo,
or
proof-of-concept.](https://www.repostatus.org/badges/latest/concept.svg)](https://www.repostatus.org/#concept)

<!-- badges: end -->

**pkgdev** provides helpers for package maintenance, documentation
rendering and [GitHub Actions](https://github.com/features/actions)
workflows. It is primarily intended for personal use, but you are
welcome to use it at your own risk.

## Installation

You can install the development version of **pkgdev** with:

``` r
pak::pak("dieghernan/pkgdev")
```

Alternatively, you can install **pkgdev** from
[r-universe](https://dieghernan.r-universe.dev/pkgdev):

``` r
# Install pkgdev in R:
install.packages("pkgdev", repos = c(
  "https://dieghernan.r-universe.dev",
  "https://cloud.r-project.org"
))
```

## Example

``` r
library(pkgdev)

gha_update_docs()
```

Document created with package pkgdev **v0.1.0.9150**.

## Related resources

- The [tidyverse style guide](https://style.tidyverse.org/).
- **ThinkR**: [Preparing your package for a CRAN
  submission](https://github.com/ThinkR-open/prepare-for-cran).
- Davis Vaughan:
  [extrachecks](https://github.com/DavisVaughan/extrachecks).
- The **usethis** package: [Create a release checklist in a GitHub
  issue](https://usethis.r-lib.org/reference/use_release_issue.html)
- The full [**usethis** package website](https://usethis.r-lib.org).
