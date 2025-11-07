library(dplyr)

# Create db
tb <- tibble(
  colnames = c(
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
)

tb$dark_spec <- c(
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
) %>%
  toupper()

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
) %>%
  toupper()

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
) %>%
  toupper()

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
) %>%
  toupper()

clipr::write_clip(tb)


# Check R Script Dark ----
bpath <- "inst/themes/rthemes_Selenized_Dark.R"
rs <- readLines(bpath)

thecols <- rs %>%
  paste(collapse = "") %>%
  str_split("#") %>%
  map(str_sub, end = 6) %>%
  unlist() %>%
  paste0("#", .)

thecols[!thecols %in% tb$dark_spec]
source(bpath)

# OK

# Create Black -----
ncols <- seq_len(nrow(tb))
rs_bk <- rs

for (i in ncols) {
  rs_bk <- gsub(tb$dark_spec[i], tb$black_spec[i], rs_bk, ignore.case = TRUE)
}

rs_bk <- gsub("Selenized Dark", "Selenized Black", rs_bk)
rs_bk == rs
rs_bk %>%
  writeLines(gsub("Dark", "Black", bpath))

# Check

bkcols <- gsub("Dark", "Black", bpath) %>%
  readLines() %>%
  paste(collapse = "") %>%
  str_split("#") %>%
  map(str_sub, end = 6) %>%
  unlist() %>%
  paste0("#", .)

bkcols[!bkcols %in% tb$black_spec]

gsub("Dark", "Black", bpath) %>% source()


# Create Light -----
rs_bk <- rs

for (i in ncols) {
  rs_bk <- gsub(tb$dark_spec[i], tb$light_spec[i], rs_bk, ignore.case = TRUE)
}
rs_bk == rs

rs_bk <- gsub("Selenized Dark", "Selenized Light", rs_bk)
rs_bk <- gsub("dark <- TRUE", "dark <- FALSE", rs_bk)

rs_bk == rs
rs_bk %>%
  writeLines(gsub("Dark", "Light", bpath))

# Check

bkcols <- gsub("Dark", "Light", bpath) %>%
  readLines() %>%
  paste(collapse = "") %>%
  str_split("#") %>%
  map(str_sub, end = 6) %>%
  unlist() %>%
  paste0("#", .)

bkcols[!bkcols %in% tb$light_spec]

gsub("Dark", "Light", bpath) %>% source()


# Create White -----
rs_bk <- rs

for (i in ncols) {
  rs_bk <- gsub(tb$dark_spec[i], tb$white_spec[i], rs_bk, ignore.case = TRUE)
}
rs_bk == rs

rs_bk <- gsub("Selenized Dark", "Selenized White", rs_bk)
rs_bk <- gsub("dark <- TRUE", "dark <- FALSE", rs_bk)

rs_bk == rs
rs_bk %>%
  writeLines(gsub("Dark", "White", bpath))

# Check

bkcols <- gsub("Dark", "White", bpath) %>%
  readLines() %>%
  paste(collapse = "") %>%
  str_split("#") %>%
  map(str_sub, end = 6) %>%
  unlist() %>%
  paste0("#", .)

bkcols[!bkcols %in% tb$white_spec]

gsub("Dark", "White", bpath) %>% source()


# Final check
rstudioapi::applyTheme("Selenized Dark")

aa <- rstudioapi::getThemes()
aa[grepl("Seleni", names(aa), ignore.case = TRUE)]
