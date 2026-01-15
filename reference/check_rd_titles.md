# Check the titles of a Rd file

Check if title of Rd files ends in a period.

## Usage

``` r
check_rd_titles(pkg = ".")
```

## Arguments

- pkg:

  Path to a (subdirectory of an) R package.

## Value

A data frame with the results.

## Examples

``` r
# \dontrun{

check_rd_titles()
#> ℹ No `.Rd` files found in path
#> NULL
# }
```
