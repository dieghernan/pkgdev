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

-   New capabilities to add contributors with
    `allcontributors::add_contributors()`.

-   Add a custom [RStudio
    Theme](https://docs.posit.co/ide/user/ide/guide/ui/appearance.html) based on
    [Selenized](https://github.com/jan-warchol/selenized), a re-design of
    [Solarized](https://ethanschoonover.com/solarized/). To install it run

    ``` r
    theme <- system.file("themes/Selenized Dark.rstheme", package = "pkgdev") 

    rstudioapi::addTheme(theme, apply = TRUE, force = TRUE)
    ```

    Alternatively, you can download the `*.rstheme` file and install it using
    `rstudioapi::addTheme()`.

# pkgdev 0.1.0

-   Added a `NEWS.md` file to track changes to the package.
