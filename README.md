
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pkgdev <img src="man/figures/logo.png" align="right" width="120"/>

<!-- badges: start -->

[![r-universe](https://dieghernan.r-universe.dev/badges/pkgdev)](https://dieghernan.r-universe.dev/)
[![R-CMD-check](https://github.com/dieghernan/pkgdev/actions/workflows/check-full.yaml/badge.svg)](https://github.com/dieghernan/pkgdev/actions/workflows/check-full.yaml)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CodeFactor](https://www.codefactor.io/repository/github/dieghernan/pkgdev/badge)](https://www.codefactor.io/repository/github/dieghernan/pkgdev)

<!-- badges: end -->

**pkgdev** is a small package that includes a set of functions that
takes advantage of [GitHub Actions
(GHA)](https://github.com/features/actions) for making your life easier
as a R package developer. This package is primarily intended for
personal use, however feel free to use it (at your own risk :wink:).

## Installation

You can install the developing version of `pkgdev` with:

``` r
devtools::install_github("dieghernan/pkgdev")
```

Alternatively, you can install `pkgdev` using the
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

## Related resources

- The [tidyverse style guide](https://style.tidyverse.org/).
- **ThinkR**: [Preparing your package for a CRAN
  submission](https://github.com/ThinkR-open/prepare-for-cran)
- Davis Vaughan:
  [extrachecks](https://github.com/DavisVaughan/extrachecks).
- **{usethis} package**: [Create a release checklist in a GitHub
  issue](https://usethis.r-lib.org/reference/use_release_issue.html)
- The whole [{usethis} package](https://usethis.r-lib.org)
