# Create a GitHub action that checks regularly your package

The GitHub action created would run `R CMD check` on your package. It
uses a wide range of platforms, can be reduced by commenting or deleting
platforms on the matrix config.

## Usage

``` r
gha_check_full(pkg = ".", overwrite = TRUE, cron_expr = "30 08 1 * *")
```

## Source

[r-lib/actions](https://github.com/r-lib/actions/tree/master/examples)

## Arguments

- pkg:

  Path to a (subdirectory of an) R package.

- overwrite:

  Overwrite the action if it was already present.

- cron_expr:

  Valid cron expression. By default, the first day of the month at 08:30
  AM. See **Details**.

## Value

A GitHub Action on `<pkg>/.github/workflows`.

## Details

Use [crontab.guru](https://crontab.guru/#30_08_1_*_*) to check and
create your own cron tag.

## See also

[`usethis::use_github_action()`](https://usethis.r-lib.org/reference/use_github_action.html)

## Examples

``` r
# \dontrun{
gha_check_full(cron_expr = "57 16 12 * *")
#> ✔ Adding "R-version" to .github/.gitignore.
#> Warning: cannot open file '/tmp/RtmpBJw2r3/file1f452ecdad1b/.github/.gitignore': No such file or directory
#> Error in file(path, open = file_mode, encoding = "utf-8"): cannot open the connection
# }
```
