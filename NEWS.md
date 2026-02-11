# pkgdev (development version)

-   Add `pkgdown` to Imports
-   Add `.imgbotconfig` to `.Rbuildignore`.
-   Remove `crayon` and use `cli` instead.
-   Use `lintr::use_lintr()` and add specific options.
-   Clean `yaml/yml` files of trailing white spaces and adds an empty line at
    the end of the file
-   **CAUTION**: `update_docs()` modifies RStudio Global and Project options.
-   New capability for optimizing images with `resmush::resmush_dir()`.
-   New function to check titles in `man` dir: `check_rd_titles()`.
-   Add configuration for [jarl linter](https://jarl.etiennebacher.com/).
-   Can precompute and render Quarto files.

# pkgdev 0.1.0

-   Added a `NEWS.md` file to track changes to the package.

