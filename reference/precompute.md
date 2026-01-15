# Precompute vignettes

Precompute vignettes from CRAN, based on
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

<https://ropensci.org/blog/2019/12/08/precompute-vignettes/>

## Arguments

- source:

  Name without path of the `.Rmd.orig` file (e.g.
  `"some_name.Rmd.orig"`).

- pkg:

  Path to a (subdirectory of an) R package.

- figure_ext:

  Extension of the figures plotted on the vignette. See **Details**.

- create_r_file:

  Whether to create an additional R file with the code of the vignette.

- dir:

  Path to directory where the "Rmd.orig" files are stored.

- ...:

  Parameters passed to `precompute_vignette()`.

## Value

A precomputed vignette

## Details

The function would search for the desired precomputed vignette on the
`"./vignettes/"` folder and for plots on the root `"./"` folder.

### Important

On your `.Rmd.orig` file make sure you have set at least the following
lines if you are producing plots:

    knitr::opts_chunk$set(
      ... ,
      fig.path = "./",
      ... ,
      )

## Examples

``` r
# \dontrun{

precompute_vignette(source = "precompute.Rmd.orig")
#> Error in package_file(path = x): Could not find package root.
#> ℹ Is . inside a package?
# }
```
