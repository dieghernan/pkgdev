# Create a GitHub Actions workflow that checks your package regularly

The GitHub Actions workflow runs `R CMD check` on your package. It uses
a wide range of platforms, which can be reduced by commenting out or
deleting platforms in the matrix configuration.

## Usage

``` r
gha_check_full(pkg = ".", overwrite = TRUE, cron_expr = "30 08 1 * *")
```

## Source

Examples from
[r-lib/actions](https://github.com/r-lib/actions/tree/master/examples).

## Arguments

- pkg:

  Path to a (subdirectory of an) R package.

- overwrite:

  Overwrite the action if it was already present.

- cron_expr:

  Valid cron expression. By default, the first day of the month at 08:30
  AM. See **Details**.

## Value

Invisibly returns `NULL` after writing a GitHub Actions workflow to
`<pkg>/.github/workflows`.

## Details

Use [crontab.guru](https://crontab.guru/#30_08_1_*_*) to check and
create your own cron tag.

## See also

- [`gha_pkgdown_branch()`](https://dieghernan.github.io/pkgdev/reference/gha_pkgdown_branch.md)
  creates a [pkgdown](https://CRAN.R-project.org/package=pkgdown)
  deployment action.

- [`gha_update_docs()`](https://dieghernan.github.io/pkgdev/reference/gha_update_docs.md)
  creates a documentation and deployment action.

- [`usethis::use_github_action()`](https://usethis.r-lib.org/reference/use_github_action.html)
  creates GitHub Actions workflows.

GitHub Actions helpers:
[`gha_pkgdown_branch()`](https://dieghernan.github.io/pkgdev/reference/gha_pkgdown_branch.md),
[`gha_update_docs()`](https://dieghernan.github.io/pkgdev/reference/gha_update_docs.md)

## Examples

``` r
# \dontrun{
gha_check_full(cron_expr = "57 16 12 * *")
#> ✔ Adding "R-version" to .github/.gitignore.
#> Warning: cannot open file '/tmp/RtmpuO4lqm/file1b235c24957f/.github/.gitignore': No such file or directory
#> Error in file(path, open = file_mode, encoding = "utf-8"): cannot open the connection
# }
```
