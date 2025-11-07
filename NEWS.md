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


-   Add a collection of [RStudio
    Themes](https://docs.posit.co/ide/user/ide/guide/ui/appearance.html) based
    on [Selenized](https://github.com/jan-warchol/selenized) by Jan Warchol, a
    re-design of [Solarized](https://ethanschoonover.com/solarized/) by Ethan
    Schoonover. To install a theme run:

    ``` r
    theme <- system.file("themes/Selenized Dark.rstheme", package = "pkgdev") 

    rstudioapi::addTheme(theme, apply = TRUE, force = TRUE)
    ```

    Alternatively, you can
    [download](https://github.com/dieghernan/pkgdev/tree/main/inst/themes) the
    `*.rstheme` file and install it using `rstudioapi::addTheme()`.

# pkgdev 0.1.0

-   Added a `NEWS.md` file to track changes to the package.
