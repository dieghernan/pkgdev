# Inspect Rd file titles

Checks generated Rd file titles for sentence case and trailing periods.

## Usage

``` r
check_rd_titles(pkg = ".")
```

## Arguments

- pkg:

  Path to the package root directory.

## Value

A [data frame](https://rdrr.io/r/base/data.frame.html) with one row per
Rd file and columns for the source path, title, sentence-case title,
final character and sentence-case check. Returns
[`NULL`](https://rdrr.io/r/base/NULL.html) if no Rd files are found.

## See also

[`update_docs()`](https://dieghernan.github.io/pkgdev/reference/update_docs.md)
runs this check after roxygenizing the package.

## Examples

``` r
# \dontrun{
check_rd_titles()
#> ℹ No Rd files found in ./man.
#> NULL
# }
```
