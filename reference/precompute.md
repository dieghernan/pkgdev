# Precompute vignettes

Precompute vignettes following the CRAN approach described at
<https://ropensci.org/blog/2019/12/08/precompute-vignettes/>.

## Usage

``` r
precompute_vignette(
  source,
  pkg = ".",
  figure_ext = ".png",
  create_r_file = FALSE
)

precompute_vignette_all(dir = "vignettes", pkg = ".", ...)
```

## Source

Based on <https://ropensci.org/blog/2019/12/08/precompute-vignettes/>.

## Arguments

- source:

  Name of the `.Rmd.orig` or `.qmd.orig` file, without the path (e.g.
  `"some_name.Rmd.orig"` or `"some_name.qmd.orig"`).

- pkg:

  Path to the package root directory.

- figure_ext:

  File extension for figures plotted in the vignette. See **Details**.

- create_r_file:

  Whether to create an additional R script with the code from the
  vignette.

- dir:

  Path to the directory where the `.Rmd.orig` and `.qmd.orig` files are
  stored.

- ...:

  Additional arguments passed to `precompute_vignette()`.

## Value

[`NULL`](https://rdrr.io/r/base/NULL.html), invisibly, after
precomputing the vignettes.

## Details

This function reads vignette source files from the package's `vignettes`
directory and moves plots from the package root to that directory.

`precompute_vignette()` processes the files named in `source`.
`precompute_vignette_all()` finds and processes every `.Rmd.orig` and
`.qmd.orig` file in `dir`.

### Important

In your `.Rmd.orig` or `.qmd.orig` file, set the following chunk option
when producing plots:

    knitr::opts_chunk$set(
      ...,
      fig.path = "./",
      ...,
    )

## See also

[`update_docs()`](https://dieghernan.github.io/pkgdev/reference/update_docs.md)
runs the broader package maintenance workflow.

Documentation rendering helpers:
[`build_qmd()`](https://dieghernan.github.io/pkgdev/reference/build_qmd.md)

## Examples

``` r
# \dontrun{
precompute_vignette(source = "precompute.Rmd.orig")
#> Error in package_file(path = x): Could not find package root.
#> ℹ Is . inside a package?
# }
```
