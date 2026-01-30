# Document your package

Run routine checks on the package:

- Clean DESCRIPTION with
  [`usethis::use_tidy_description()`](https://usethis.r-lib.org/reference/tidyverse.html)

- Compress the data of the paths `"./data"` and `"./R"` using
  [`tools::resaveRdaFiles()`](https://rdrr.io/r/tools/checkRdaFiles.html).

- Style code with
  [`styler::style_pkg()`](https://styler.r-lib.org/reference/style_pkg.html)

- Check urls with
  [`urlchecker::url_check()`](https://rdrr.io/pkg/urlchecker/man/url_check.html)

- Roxygenise with
  [`roxygen2::roxygenise()`](https://roxygen2.r-lib.org/reference/roxygenize.html)

- Precompute vignettes if present (see
  <https://ropensci.org/blog/2019/12/08/precompute-vignettes/>)

- Rebuild `README.Rmd` (if present) with
  [`devtools::build_readme()`](https://devtools.r-lib.org/reference/build_rmd.html)

- Optimize images with
  [`resmush::resmush_dir()`](https://dieghernan.github.io/resmush/reference/resmush_dir.html)

- Write codemeta.json with
  [`codemetar::write_codemeta()`](https://docs.ropensci.org/codemetar/reference/write_codemeta.html)

- Write CITATION.cff with
  [`cffr::cff_write()`](https://docs.ropensci.org/cffr/reference/cff_write.html)

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
  opt_dir = c("man/figures", "vignettes", "pkgdown/favicon"),
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

  Logical, do you want to update urls with
  [`urlchecker::url_update()`](https://rdrr.io/pkg/urlchecker/man/url_update.html)?

- create_codemeta:

  Logical, do you want to create a codemeta file with
  [`codemetar::write_codemeta()`](https://docs.ropensci.org/codemetar/reference/write_codemeta.html)?

- create_cff:

  Logical, do you want to create a CITATION.cff file with
  [`cffr::cff_write()`](https://docs.ropensci.org/cffr/reference/cff_write.html)?

- build_readme:

  Logical, build `README.Rmd` with
  [`devtools::build_readme()`](https://devtools.r-lib.org/reference/build_rmd.html)

- verbose:

  Display informative messages on the console

- precompute:

  Logical, detect and precompute vignettes? See also
  [`precompute_vignette()`](https://dieghernan.github.io/pkgdev/reference/precompute.md).

- opt_imgs:

  Logical. Optimize images with
  [`resmush::resmush_dir()`](https://dieghernan.github.io/resmush/reference/resmush_dir.html)?

- opt_dir, opt_ext, opt_overwrite:

  See `dir`, `ext` and `overwrite` in
  [`resmush::resmush_dir()`](https://dieghernan.github.io/resmush/reference/resmush_dir.html).

- add_contributors:

  Deprecated.

- ...:

  Additional arguments to functions

## Value

invisible, or some messages on `verbose = TRUE`.

## Details

This function tries to update and clean the package following a mix of
best practices (e.g. checking the urls, roxygenise and rebuilding the
`README`) and some other discretionary practices I like to have in a
package, as the `tidyverse` approach for the `DESCRIPTION` file and
overall code and the use of `codemeta.json`.

## See also

[`usethis::use_tidy_description()`](https://usethis.r-lib.org/reference/tidyverse.html),
[`styler::style_pkg()`](https://styler.r-lib.org/reference/style_pkg.html),
[`urlchecker::url_check()`](https://rdrr.io/pkg/urlchecker/man/url_check.html),
[`roxygen2::roxygenise()`](https://roxygen2.r-lib.org/reference/roxygenize.html),
[`devtools::build_readme()`](https://devtools.r-lib.org/reference/build_rmd.html),
[`codemetar::write_codemeta()`](https://docs.ropensci.org/codemetar/reference/write_codemeta.html),
[`tools::resaveRdaFiles()`](https://rdrr.io/r/tools/checkRdaFiles.html)

## Examples

``` r
# \dontrun{

update_docs()
#> ℹ Adding .gitignore to root
#> Warning: cannot open file '.gitignore': No such file or directory
#> Error in file(con, "r"): cannot open the connection
# }
```
