# Precompute vignettes

Precompute vignettes using the CRAN approach, based on
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

  Path to a (subdirectory of an) R package.

- figure_ext:

  Extension of the figures plotted in the vignette. See **Details**.

- create_r_file:

  Whether to create an additional R script with the code of the
  vignette.

- dir:

  Path to the directory where the `.Rmd.orig` and `.qmd.orig` files are
  stored.

- ...:

  Parameters passed to `precompute_vignette()`.

## Value

Invisibly returns `NULL` after writing a precomputed vignette.

## Details

This function searches for the desired precomputed vignette in the
`"./vignettes/"` directory and for plots in the root `"./"` directory.

### Important

In your `.Rmd.orig` or `.qmd.orig` file, make sure you have set at least
the following lines if you are producing plots:

    knitr::opts_chunk$set(
      ...,
      fig.path = "./",
      ...,
    )

## See also

- [`build_qmd()`](https://dieghernan.github.io/pkgdev/reference/build_qmd.md)
  builds Quarto files.

- [`build_readme_qmd()`](https://dieghernan.github.io/pkgdev/reference/build_qmd.md)
  builds `README.qmd` files.

Documentation renderers:
[`build_qmd()`](https://dieghernan.github.io/pkgdev/reference/build_qmd.md)

## Examples

``` r
# \dontrun{
precompute_vignette(source = "precompute.Rmd.orig")
#> Error in package_file(path = x): Could not find package root.
#> ℹ Is . inside a package?
# }
```
