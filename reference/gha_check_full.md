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

  Path to the package root directory.

- overwrite:

  Whether to overwrite an existing workflow file.

- cron_expr:

  A valid cron expression. Defaults to 08:30 UTC on the first day of the
  month. See **Details**.

## Value

[`NULL`](https://rdrr.io/r/base/NULL.html), invisibly, after writing a
GitHub Actions workflow to `<pkg>/.github/workflows`.

## Details

Use [crontab.guru](https://crontab.guru/#30_08_1_*_*) to check and
create your own cron expression.

## See also

[`usethis::use_github_action()`](https://usethis.r-lib.org/reference/use_github_action.html)
creates GitHub Actions workflows.

GitHub Actions workflow helpers:
[`gha_pkgdown_branch()`](https://dieghernan.github.io/pkgdev/reference/gha_pkgdown_branch.md),
[`gha_update_docs()`](https://dieghernan.github.io/pkgdev/reference/gha_update_docs.md)

## Examples

``` r
# \dontrun{
gha_check_full(cron_expr = "57 16 12 * *")
#> ✔ Adding "R-version" to .github/.gitignore.
#> Warning: cannot open file '/tmp/Rtmp9BJlab/file1a591438e479/.github/.gitignore': No such file or directory
#> Error in file(path, open = file_mode, encoding = "utf-8"): cannot open the connection
# }
```
