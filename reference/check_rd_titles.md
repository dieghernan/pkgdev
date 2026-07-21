# Inspect Rd file titles

Inspect generated Rd file titles for sentence case and trailing periods.

## Usage

``` r
check_rd_titles(pkg = ".")
```

## Arguments

- pkg:

  Path to a (subdirectory of an) R package.

## Value

A data frame with one row per Rd file and columns for the source path,
title, sentence-case title, final character and sentence-case check.

## See also

[`update_docs()`](https://dieghernan.github.io/pkgdev/reference/update_docs.md)
runs this check after roxygenizing the package.

## Examples

``` r
# \dontrun{
check_rd_titles()
#> ℹ No .Rd files found in ./man.
#> NULL
# }
```
