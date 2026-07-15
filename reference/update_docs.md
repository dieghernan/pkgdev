# Document your package

Run routine checks on the package:

- Clean `DESCRIPTION` with
  [`usethis::use_tidy_description()`](https://usethis.r-lib.org/reference/tidyverse.html).

- Compress data in the `"./data"` and `"./R"` paths using
  [`tools::resaveRdaFiles()`](https://rdrr.io/r/tools/checkRdaFiles.html).

- Style code with
  [`styler::style_pkg()`](https://styler.r-lib.org/reference/style_pkg.html).

- Check URLs with
  [`urlchecker::url_check()`](https://urlchecker.r-lib.org/reference/url_check.html).

- Roxygenize with
  [`roxygen2::roxygenise()`](https://roxygen2.r-lib.org/reference/roxygenize.html).

- Precompute vignettes, if present (see
  <https://ropensci.org/blog/2019/12/08/precompute-vignettes/>).

- Rebuild `README.Rmd`, if present, with
  [`devtools::build_readme()`](https://devtools.r-lib.org/reference/build_readme.html).

- Optimize images with
  [`resmush::resmush_dir()`](https://dieghernan.github.io/resmush/reference/resmush_dir.html).

- Write `codemeta.json` with
  [`codemetar::write_codemeta()`](https://docs.ropensci.org/codemetar/reference/write_codemeta.html).

- Write `CITATION.cff` with
  [`cffr::cff_write()`](https://docs.ropensci.org/cffr/reference/cff_write.html).

## Usage

``` r
update_docs(
  pkg = ".",
  url_update = TRUE,
  create_codemeta = TRUE,
  create_cff = TRUE,
  build_readme = TRUE,
  verbose = TRUE,
  precompute = TRUE,
  opt_imgs = TRUE,
  opt_dir = c("man/figures", "vignettes"),
  opt_ext = "png$|jpg$",
  opt_overwrite = TRUE,
  add_contributors = TRUE,
  ...
)
```

## Arguments

- pkg:

  Path to a (subdirectory of an) R package.

- url_update:

  A logical value. Should URLs be updated with
  [`urlchecker::url_update()`](https://urlchecker.r-lib.org/reference/url_update.html)?

- create_codemeta:

  A logical value. Should `codemeta.json` be created with
  [`codemetar::write_codemeta()`](https://docs.ropensci.org/codemetar/reference/write_codemeta.html)?

- create_cff:

  A logical value. Should `CITATION.cff` be created with
  [`cffr::cff_write()`](https://docs.ropensci.org/cffr/reference/cff_write.html)?

- build_readme:

  A logical value. Should `README.Rmd` be built with
  [`devtools::build_readme()`](https://devtools.r-lib.org/reference/build_readme.html)?

- verbose:

  A logical value. Should informative messages be displayed on the
  console?

- precompute:

  A logical value. Should vignettes be detected and precomputed? See
  also
  [`precompute_vignette()`](https://dieghernan.github.io/pkgdev/reference/precompute.md).

- opt_imgs:

  A logical value. Should images be optimized with
  [`resmush::resmush_dir()`](https://dieghernan.github.io/resmush/reference/resmush_dir.html)?

- opt_dir, opt_ext, opt_overwrite:

  Options passed to the `dir`, `ext` and `overwrite` arguments of
  [`resmush::resmush_dir()`](https://dieghernan.github.io/resmush/reference/resmush_dir.html).

- add_contributors:

  Deprecated.

- ...:

  Additional arguments passed to downstream functions.

## Value

Invisibly returns `NULL`. When `verbose = TRUE`, it emits progress
messages.

## Details

This function updates and cleans the package using a mix of best
practices, such as checking URLs, roxygenizing and rebuilding the
`README`. It also applies discretionary practices such as the tidyverse
approach for the `DESCRIPTION` file, overall code style and
`codemeta.json`.

## See also

- [`add_global_gitgnore()`](https://dieghernan.github.io/pkgdev/reference/add_global_gitgnore.md)
  updates package ignore files.

- [`build_qmd()`](https://dieghernan.github.io/pkgdev/reference/build_qmd.md)
  builds Quarto files.

- [`check_rd_titles()`](https://dieghernan.github.io/pkgdev/reference/check_rd_titles.md)
  checks generated Rd titles.

- [`precompute_vignette()`](https://dieghernan.github.io/pkgdev/reference/precompute.md)
  precomputes vignettes.

- [`usethis::use_tidy_description()`](https://usethis.r-lib.org/reference/tidyverse.html)
  cleans `DESCRIPTION`.

- [`styler::style_pkg()`](https://styler.r-lib.org/reference/style_pkg.html)
  styles package code.

- [`urlchecker::url_check()`](https://urlchecker.r-lib.org/reference/url_check.html)
  checks URLs.

- [`roxygen2::roxygenise()`](https://roxygen2.r-lib.org/reference/roxygenize.html)
  updates documentation.

- [`devtools::build_readme()`](https://devtools.r-lib.org/reference/build_readme.html)
  builds `README.Rmd`.

- [`codemetar::write_codemeta()`](https://docs.ropensci.org/codemetar/reference/write_codemeta.html)
  writes `codemeta.json`.

- [`tools::resaveRdaFiles()`](https://rdrr.io/r/tools/checkRdaFiles.html)
  compresses data files.

Package maintenance helpers:
[`add_global_gitgnore()`](https://dieghernan.github.io/pkgdev/reference/add_global_gitgnore.md)

## Examples

``` r
# \dontrun{
update_docs()
#> ℹ Adding .gitignore to root
#> Warning: cannot open file '.gitignore': No such file or directory
#> Error in file(con, "r"): cannot open the connection
# }
```
