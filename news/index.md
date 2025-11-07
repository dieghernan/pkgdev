# Changelog

## pkgdev (development version)

- Add `pkgdown` to Imports

- Add `.imgbotconfig` to `.Rbuildignore`.

- Remove `crayon` and use `cli` instead.

- Use
  [`lintr::use_lintr()`](https://lintr.r-lib.org/reference/use_lintr.html)
  and add specific options.

- Clean `yaml/yml` files of trailing white spaces and adds an empty line
  at the end of the file

- **CAUTION**:
  [`update_docs()`](https://dieghernan.github.io/pkgdev/reference/update_docs.md)
  modifies RStudio Global and Project options.

- New capability for optimizing images with
  [`resmush::resmush_dir()`](https://dieghernan.github.io/resmush/reference/resmush_dir.html).

- New function to check titles in `man` dir:
  [`check_rd_titles()`](https://dieghernan.github.io/pkgdev/reference/check_rd_titles.md).

- Add a collection of [RStudio
  Themes](https://docs.posit.co/ide/user/ide/guide/ui/appearance.html)
  based on [Selenized](https://github.com/jan-warchol/selenized) by Jan
  Warchol, a re-design of
  [Solarized](https://ethanschoonover.com/solarized/) by Ethan
  Schoonover. To install a theme run:

  ``` r
  theme <- system.file("themes/Selenized Dark.rstheme", package = "pkgdev") 

  rstudioapi::addTheme(theme, apply = TRUE, force = TRUE)
  ```

  Alternatively, you can
  [download](https://github.com/dieghernan/pkgdev/tree/main/inst/themes)
  the `*.rstheme` file and install it using
  [`rstudioapi::addTheme()`](https://rstudio.github.io/rstudioapi/reference/addTheme.html).

## pkgdev 0.1.0

- Added a `NEWS.md` file to track changes to the package.
