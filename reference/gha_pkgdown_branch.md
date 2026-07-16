# Create a GitHub Actions workflow that builds a [pkgdown](https://CRAN.R-project.org/package=pkgdown) site

The GitHub Actions workflow deploys a
[pkgdown](https://CRAN.R-project.org/package=pkgdown) site for your
package on the `gh-pages` branch.

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

  Path to a (subdirectory of an) R package.

- overwrite:

  Overwrite the action if it was already present.

- platform:

  Platform to use for deploying the package. See **Details**.

- version:

  Version of the platform. See **Details**.

## Value

Invisibly returns `NULL` after writing a GitHub Actions workflow to
`<pkg>/.github/workflows`.

## Details

Check <https://github.com/actions/runner-images> to see the available
options.

## See also

- [`gha_check_full()`](https://dieghernan.github.io/pkgdev/reference/gha_check_full.md)
  creates a full package check action.

- [`gha_update_docs()`](https://dieghernan.github.io/pkgdev/reference/gha_update_docs.md)
  creates a documentation and deployment action.

GitHub Actions helpers:
[`gha_check_full()`](https://dieghernan.github.io/pkgdev/reference/gha_check_full.md),
[`gha_update_docs()`](https://dieghernan.github.io/pkgdev/reference/gha_update_docs.md)

## Examples

``` r
# \dontrun{
# With Ubuntu 20.04
gha_pkgdown_branch(platform = "ubuntu", version = "20.04")
#> ✔ Adding "R-version" to .github/.gitignore.
#> Warning: cannot open file '/tmp/Rtmpl7FfEa/file1b442e508859/.github/.gitignore': No such file or directory
#> Error in file(path, open = file_mode, encoding = "utf-8"): cannot open the connection
# }
```
