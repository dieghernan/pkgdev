# Changelog

## pkgdev (development version)

- Added `.imgbotconfig` to `.Rbuildignore`.
- Added configuration for the [jarl
  linter](https://jarl.etiennebacher.com/).
- Added **pkgdown** to Imports.
- Included an RStudio add-in.
- Removed **crayon** and now use **cli** instead.
- [`check_rd_titles()`](https://dieghernan.github.io/pkgdev/reference/check_rd_titles.md)
  checks titles in the `man` directory.
- [`update_docs()`](https://dieghernan.github.io/pkgdev/reference/update_docs.md)
  can clean YAML files of trailing whitespace and add a final blank
  line.
- [`update_docs()`](https://dieghernan.github.io/pkgdev/reference/update_docs.md)
  can optimize images with
  [`resmush::resmush_dir()`](https://dieghernan.github.io/resmush/reference/resmush_dir.html).
- [`update_docs()`](https://dieghernan.github.io/pkgdev/reference/update_docs.md)
  can precompute vignettes and render Quarto files.
- [`update_docs()`](https://dieghernan.github.io/pkgdev/reference/update_docs.md)
  now uses
  [`lintr::use_lintr()`](https://lintr.r-lib.org/reference/use_lintr.html)
  and adds package-specific options.
- **Caution:**
  [`update_docs()`](https://dieghernan.github.io/pkgdev/reference/update_docs.md)
  modifies global and project-level RStudio options.

## pkgdev 0.1.0

- Added a `NEWS.md` file to track changes to the package.
