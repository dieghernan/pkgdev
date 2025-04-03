# Custom RStudio Theme

This is a custom [RStudio
Theme](https://docs.posit.co/ide/user/ide/guide/ui/appearance.html) based on
[Selenized](https://github.com/jan-warchol/selenized), a re-design of
[Solarized](https://ethanschoonover.com/solarized/). To install it run

``` r
theme <- system.file("themes/Selenized Dark.rstheme", package = "pkgdev")
rstudioapi::addTheme(theme, apply = TRUE, force = TRUE)
```

Alternatively, you can download the `*.rstheme` file and install it using
`rstudioapi::addTheme()`.

## Development

The specification is done in the `*.tmTheme`. See also
<https://tmtheme-editor.glitch.me/> to create a `*.tmTheme` file online. Also
some example files can be found in
<https://github.com/filmgirl/TextMate-Themes>.

The conversion script can be found in `create_theme.R`. This would generate a
`*.rstheme` file that can be further modified and install in RStudio with
`rstudioapi::addTheme()`.
