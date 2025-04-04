# Selenized RStudio Theme

These are custom [RStudio
Themes](https://docs.posit.co/ide/user/ide/guide/ui/appearance.html) based on
[Selenized](https://github.com/jan-warchol/selenized) by Jan Warchol, a
re-design of [Solarized](https://ethanschoonover.com/solarized/) by Ethan
Schoonover. To install a theme run

``` r
theme <- system.file("themes/Selenized Dark.rstheme", package = "pkgdev")

rstudioapi::addTheme(theme, apply = TRUE, force = TRUE)
```

Alternatively, you can download the `*.rstheme` file and install it using
`rstudioapi::addTheme()`.

## Themes

From <https://github.com/jan-warchol/selenized/blob/master/the-values.md>

| color      | Selenized Black | Selenized Dark | Selenized Light | Selenized White |
|------------|-----------------|----------------|-----------------|-----------------|
| bg_0       | #181818         | #103C48        | #FBF3DB         | #FFFFFF         |
| bg_1       | #252525         | #184956        | #ECE3CC         | #EBEBEB         |
| bg_2       | #3B3B3B         | #2D5B69        | #D5CDB6         | #CDCDCD         |
| dim_0      | #777777         | #72898F        | #909995         | #878787         |
| fg_0       | #B9B9B9         | #ADBCBC        | #53676D         | #474747         |
| fg_1       | #DEDEDE         | #CAD8D9        | #3A4D53         | #282828         |
| red        | #ED4A46         | #FA5750        | #D2212D         | #D6000C         |
| green      | #70B433         | #75B938        | #489100         | #1D9700         |
| yellow     | #DBB32D         | #DBB32D        | #AD8900         | #C49700         |
| blue       | #368AEB         | #4695F7        | #0072D4         | #0064E4         |
| magenta    | #EB6EB7         | #F275BE        | #CA4898         | #DD0F9D         |
| cyan       | #3FC5B7         | #41C7B9        | #009C8F         | #00AD9C         |
| orange     | #E67F43         | #ED8649        | #C25D1E         | #D04A00         |
| violet     | #A580E2         | #AF88EB        | #8762C6         | #7F51D6         |
| br_red     | #FF5E56         | #FF665C        | #CC1729         | #BF0000         |
| br_green   | #83C746         | #84C747        | #428B00         | #008400         |
| br_yellow  | #EFC541         | #EBC13D        | #A78300         | #AF8500         |
| br_blue    | #4F9CFE         | #58A3FF        | #006DCE         | #0054CF         |
| br_magenta | #FF81CA         | #FF84CD        | #C44392         | #C7008B         |
| br_cyan    | #56D8C9         | #53D6C7        | #00978A         | #009A8A         |
| br_orange  | #FA9153         | #FD9456        | #BC5819         | #BA3700         |
| br_violet  | #B891F5         | #BD96FA        | #825DC0         | #6B40C3         |

### Selenized black

![Selenized black screenshot](http://i.imgur.com/rXIH87x.png)

### Selenized dark

![Selenized dark screenshot](http://i.imgur.com/yM0vadH.png)

### Selenized light

![Selenized light screenshot](http://i.imgur.com/kQVgD5U.png)

### Selenized white

![Selenized white screenshot](https://imgur.com/sc0Uv9h.png)

## Development notes

Specification using [**rsthemes**](https://github.com/gadenbuie/rsthemes)

The conversion script can be found in `rthemes_create.R`. This would generate a
`rsthemes_Selenized_XXX.R` script that can be `source()`d to build the `rstheme`
file, later installed using `rstudioapi::addTheme()`.
