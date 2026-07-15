# pkgdev (development version)

- Added `.imgbotconfig` to `.Rbuildignore`.
- Added configuration for the [jarl linter](https://jarl.etiennebacher.com/).
- Added **pkgdown** to Imports.
- Included an RStudio add-in.
- Removed **crayon** and now use **cli** instead.
- `check_rd_titles()` checks titles in the `man` directory.
- `update_docs()` can clean YAML files of trailing whitespace and add a final
  blank line.
- `update_docs()` can optimize images with `resmush::resmush_dir()`.
- `update_docs()` can precompute vignettes and render Quarto files.
- `update_docs()` now uses `lintr::use_lintr()` and adds package-specific
  options.
- **Caution:** `update_docs()` modifies global and project-level RStudio
  options.

# pkgdev 0.1.0

- Added a `NEWS.md` file to track changes to the package.
