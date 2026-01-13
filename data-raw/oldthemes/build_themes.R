ss <- xml2::read_xml("inst/themes/Selenized Dark.tmTheme")
library(tidyverse)

thecols_init <- xml_text(ss) |>
  str_split("#") |>
  lapply(str_sub, end = 6) |>
  unlist() |>
  paste0("#", .) |>
  toupper()

thecols <- unique(thecols_init)
tb_theme <- tibble(cols = thecols_init) |>
  group_by(cols) |>
  count()

rstudioapi::getThemeInfo()

thespec <- c(
  "#103c48",
  "#184956",
  "#2d5b69",
  "#72898f",
  "#adbcbc",
  "#cad8d9",
  "#fa5750",
  "#75b938",
  "#dbb32d",
  "#4695f7",
  "#f275be",
  "#41c7b9",
  "#ed8649",
  "#af88eb",
  "#ff665c",
  "#84c747",
  "#ebc13d",
  "#58a3ff",
  "#ff84cd",
  "#53d6c7",
  "#fd9456",
  "#bd96fa"
) |>
  toupper()

thecols[!thecols %in% thespec]


tb <- tibble(cols = thespec)
tb$in_theme <- tb$cols %in% thecols
tb$nm <- c(
  "bg_0",
  "bg_1",
  "bg_2",
  "dim_0",
  "fg_0",
  "fg_1",
  "red",
  "green",
  "yellow",
  "blue",
  "magenta",
  "cyan",
  "orange",
  "violet",
  "br_red",
  "br_green",
  "br_yellow",
  "br_blue",
  "br_magenta",
  "br_cyan",
  "br_orange",
  "br_violet"
)

tb <- tb |>
  select(nm, cols, in_theme) |>
  left_join(tb_theme)
clipr::write_clip(tb)
# Fix uppercase
lb <- readLines("inst/themes/Selenized Dark.tmTheme")
ncols <- seq_len(nrow(tb))

for (i in ncols) {
  lb <- gsub(tb$cols[i], toupper(tb$cols[i]), lb, ignore.case = TRUE)
}

writeLines(lb, "inst/themes/Selenized Dark.tmTheme")


# Create Black theme ----

tb$black_spec <- c(
  "#181818",
  "#252525",
  "#3b3b3b",
  "#777777",
  "#b9b9b9",
  "#dedede",
  "#ed4a46",
  "#70b433",
  "#dbb32d",
  "#368aeb",
  "#eb6eb7",
  "#3fc5b7",
  "#e67f43",
  "#a580e2",
  "#ff5e56",
  "#83c746",
  "#efc541",
  "#4f9cfe",
  "#ff81ca",
  "#56d8c9",
  "#fa9153",
  "#b891f5"
) |>
  toupper()

# "#ADBCBC" "#2D5B69" "#FA5750" "#75B938" "#41C7B9"

btheme <- "inst/themes/Selenized Black.tmTheme"

lb <- readLines(btheme)
ncols <- seq_len(nrow(tb))

for (i in ncols) {
  lb <- gsub(tb$cols[i], tb$black_spec[i], lb, ignore.case = TRUE)
}

writeLines(lb, btheme)


ss <- xml2::read_xml(btheme)

thecols_init <- xml_text(ss) |>
  str_split("#") |>
  lapply(str_sub, end = 6) |>
  unlist() |>
  paste0("#", .) |>
  toupper() |>
  unique()

thecols_init[!thecols_init %in% tb$black_spec]

# Create Light theme ----
tb$light_spec <- c(
  "#fbf3db",
  "#ece3cc",
  "#d5cdb6",
  "#909995",
  "#53676d",
  "#3a4d53",
  "#d2212d",
  "#489100",
  "#ad8900",
  "#0072d4",
  "#ca4898",
  "#009c8f",
  "#c25d1e",
  "#8762c6",
  "#cc1729",
  "#428b00",
  "#a78300",
  "#006dce",
  "#c44392",
  "#00978a",
  "#bc5819",
  "#825dc0"
) |>
  toupper()


ltheme <- "inst/themes/Selenized Light.tmTheme"

lb <- readLines(ltheme)
ncols <- seq_len(nrow(tb))

for (i in ncols) {
  lb <- gsub(tb$black_spec[i], tb$light_spec[i], lb, ignore.case = TRUE)
}

writeLines(lb, ltheme)


ss <- xml2::read_xml(ltheme)

thecols_init <- xml_text(ss) |>
  str_split("#") |>
  lapply(str_sub, end = 6) |>
  unlist() |>
  paste0("#", .) |>
  toupper() |>
  unique()

thecols_init[!thecols_init %in% tb$light_spec]

# Create white theme ----

tb$white_spec <- c(
  "#ffffff",
  "#ebebeb",
  "#cdcdcd",
  "#878787",
  "#474747",
  "#282828",
  "#d6000c",
  "#1d9700",
  "#c49700",
  "#0064e4",
  "#dd0f9d",
  "#00ad9c",
  "#d04a00",
  "#7f51d6",
  "#bf0000",
  "#008400",
  "#af8500",
  "#0054cf",
  "#c7008b",
  "#009a8a",
  "#ba3700",
  "#6b40c3"
) |>
  toupper()

wtheme <- "inst/themes/Selenized White.tmTheme"

lb <- readLines(wtheme)
ncols <- seq_len(nrow(tb))

for (i in ncols) {
  lb <- gsub(tb$light_spec[i], tb$white_spec[i], lb, ignore.case = TRUE)
}

writeLines(lb, wtheme)


ss <- xml2::read_xml(wtheme)

thecols_init <- xml_text(ss) |>
  str_split("#") |>
  lapply(str_sub, end = 6) |>
  unlist() |>
  paste0("#", .) |>
  toupper() |>
  unique()

thecols_init[!thecols_init %in% tb$white_spec]
