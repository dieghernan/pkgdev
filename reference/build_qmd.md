# Build a Quarto files package

`build_qmd()` is a wrapper around
[`quarto::quarto_render()`](https://quarto-dev.github.io/quarto-r/reference/quarto_render.html)
that first installs a temporary copy of the package, and then renders
each .Rmd in a clean R session. `build_readme_qmd()` locates your
README.and builds it into a README.md

## Usage

``` r
build_qmd(files, path = ".", ..., quiet = TRUE)

build_readme_qmd(path = ".", quiet = TRUE, ...)
```

## Arguments

- files:

  The Quarto files to be rendered.

- path:

  path to the package to build the readme.

- ...:

  additional arguments passed to
  [`quarto::quarto_render()`](https://quarto-dev.github.io/quarto-r/reference/quarto_render.html).

- quiet:

  If `TRUE`, suppress output.

## See also

[`devtools::build_readme()`](https://devtools.r-lib.org/reference/build_rmd.html)
