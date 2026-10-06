# Create a GitHub Actions workflow that builds a [pkgdown](https://CRAN.R-project.org/package=pkgdown) site

The GitHub Actions workflow deploys a
[pkgdown](https://CRAN.R-project.org/package=pkgdown) site for your
package to the `gh-pages` branch.

## Usage

``` r
gha_pkgdown_branch(
  pkg = ".",
  overwrite = TRUE,
  platform = "macOS",
  version = "latest"
)
```

## Source

Examples from
[r-lib/actions](https://github.com/r-lib/actions/tree/master/examples).

## Arguments

- pkg:

  Path to the package root directory.

- overwrite:

  Whether to overwrite an existing workflow file.

- platform:

  Runner operating system to use for deploying the site. See
  **Details**.

- version:

  Runner image version. See **Details**.

## Value

[`NULL`](https://rdrr.io/r/base/NULL.html), invisibly, after writing a
GitHub Actions workflow to `<pkg>/.github/workflows`.

## Details

Check <https://github.com/actions/runner-images> to see the available
options.

## See also

[`pkgdown::build_site()`](https://pkgdown.r-lib.org/reference/build_site.html)
builds the package website locally.

GitHub Actions workflow helpers:
[`gha_check_full()`](https://dieghernan.github.io/pkgdev/reference/gha_check_full.md),
[`gha_update_docs()`](https://dieghernan.github.io/pkgdev/reference/gha_update_docs.md)

## Examples

``` r
# \dontrun{
# With Ubuntu 20.04.
gha_pkgdown_branch(platform = "ubuntu", version = "20.04")
#> ✔ Adding "R-version" to .github/.gitignore.
#> Warning: cannot open file '/tmp/Rtmp9BJlab/file1a591438e479/.github/.gitignore': No such file or directory
#> Error in file(path, open = file_mode, encoding = "utf-8"): cannot open the connection
# }
```
