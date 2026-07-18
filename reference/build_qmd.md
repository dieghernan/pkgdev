# Build Quarto files for a package

`build_qmd()` is a wrapper around
[`quarto::quarto_render()`](https://quarto-dev.github.io/quarto-r/reference/quarto_render.html)
that first installs a temporary copy of the package, then renders each
Quarto file in a clean R session. `build_readme_qmd()` locates your
`README.qmd` and builds it into a `README.md`.

## Usage

``` r
build_qmd(files, path = ".", ..., quiet = TRUE)

build_readme_qmd(path = ".", quiet = TRUE, ...)
```

## Arguments

- files:

  Quarto files to be rendered.

- path:

  Path to the top-level directory of the source package.

- ...:

  Additional arguments passed to
  [`quarto::quarto_render()`](https://quarto-dev.github.io/quarto-r/reference/quarto_render.html).

- quiet:

  If `TRUE`, suppresses most output. Set to `FALSE` if you need to
  debug.

## Value

`TRUE`, invisibly.

## See also

- `build_readme_qmd()` builds `README.qmd` files.

- [`precompute_vignette()`](https://dieghernan.github.io/pkgdev/reference/precompute.md)
  precomputes vignettes.

- [`devtools::build_readme()`](https://devtools.r-lib.org/reference/build_readme.html)
  builds `README` files from R Markdown.

Documentation renderers:
[`precompute_vignette()`](https://dieghernan.github.io/pkgdev/reference/precompute.md)
