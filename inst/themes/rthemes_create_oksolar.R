library(tidyverse)

# thTheme file created based on the VS Code settings
# https://github.com/jan-warchol/selenized/blob/master/editors/visual-studio-code/themes/selenized-dark.json
# Use Selenized Dark theme as reference and modify rest of templates
# based in the same color scheme

# Create db
# Specs from https://github.com/jan-warchol/selenized/blob/master/the-values.md
tb <- tibble(colnames = c(
  "bg_0", "bg_1", "bg_2", "dim_0", "fg_0", "fg_1", "red", "green", "yellow",
  "blue", "magenta", "cyan", "orange", "violet", "br_red", "br_green",
  "br_yellow", "br_blue", "br_magenta", "br_cyan", "br_orange", "br_violet"
))

tb$dark_spec <- c(
  "#103c48", "#184956", "#2d5b69", "#72898f", "#adbcbc", "#cad8d9", "#fa5750",
  "#75b938", "#dbb32d", "#4695f7", "#f275be", "#41c7b9", "#ed8649", "#af88eb",
  "#ff665c", "#84c747", "#ebc13d", "#58a3ff", "#ff84cd", "#53d6c7", "#fd9456",
  "#bd96fa"
) %>%
  toupper()

tb$oksolar_dark_spec <- c(
  "#002d38", "#093946", "#5b7279", "#657377", "#98a8a8", "#8faaab", "#f23749",
  "#819500", "#ac8300", "#2b90d8", "#dd459d", "#259d94", "#d56500", "#7d80d1",
  "#f23749", "#819500", "#ac8300", "#2b90d8", "#dd459d", "#259d94", "#d56500",
  "#7d80d1") %>% toupper()

tb$oksolar_light_spec <- c(
  "#f1e9d2", "#8faaab", "#98a8a8", "#657377", "#5b7279", "#093946",  "#f23749",
  "#819500", "#ac8300", "#2b90d8", "#dd459d", "#259d94", "#d56500", "#7d80d1",
  "#f23749", "#819500", "#ac8300", "#2b90d8", "#dd459d", "#259d94", "#d56500",
  "#7d80d1") %>% toupper()


#
#
# tb$black_spec <- c(
#   "#181818", "#252525", "#3b3b3b", "#777777", "#b9b9b9", "#dedede", "#ed4a46",
#   "#70b433", "#dbb32d", "#368aeb", "#eb6eb7", "#3fc5b7", "#e67f43", "#a580e2",
#   "#ff5e56", "#83c746", "#efc541", "#4f9cfe", "#ff81ca", "#56d8c9", "#fa9153",
#   "#b891f5"
# ) %>% toupper()
#
# tb$light_spec <- c(
#   "#fbf3db", "#ece3cc", "#d5cdb6", "#909995", "#53676d", "#3a4d53", "#d2212d",
#   "#489100", "#ad8900", "#0072d4", "#ca4898", "#009c8f", "#c25d1e", "#8762c6",
#   "#cc1729", "#428b00", "#a78300", "#006dce", "#c44392", "#00978a", "#bc5819",
#   "#825dc0"
# ) %>%
#   toupper()
#
# tb$white_spec <- c(
#   "#ffffff", "#ebebeb", "#cdcdcd", "#878787", "#474747", "#282828", "#d6000c",
#   "#1d9700", "#c49700", "#0064e4", "#dd0f9d", "#00ad9c", "#d04a00", "#7f51d6",
#   "#bf0000", "#008400", "#af8500", "#0054cf", "#c7008b", "#009a8a", "#ba3700",
#   "#6b40c3"
# ) %>% toupper()


# OK Solar Dark ------
bpath <- "inst/themes/Selenized Dark.tmTheme"
spath <- "inst/themes/rthemes_Selenized_Dark.R"
rs <- readLines(bpath)
sf <- readLines(spath)

ncols <- seq_len(nrow(tb))
rs_bk <- rs

for (i in ncols) {
  rs_bk <- gsub(tb$dark_spec[i], tb$oksolar_dark_spec[i], rs_bk, ignore.case = TRUE)
}

rs_bk <- gsub("Selenized Dark", "OKSolar Dark", rs_bk)
rs_bk <- gsub("selenized_dark", "oksolar_dark", rs_bk)
rs_bk == rs


rs_bk %>%
  writeLines(gsub("Selenized Dark", "OKSolar Dark", bpath))

# Same with the script
sf_bk <- sf

for (i in ncols) {
  sf_bk <- gsub(tb$dark_spec[i], tb$oksolar_dark_spec[i], sf_bk, ignore.case = TRUE)
}

sf_bk <- gsub("Selenized Dark", "OKSolar Dark", sf_bk)
sf_bk <- gsub("selenized_dark", "oksolar_dark", sf_bk)
sf_bk == sf
sf_bk %>%
  writeLines(gsub("Selenized_Dark", "OKSolar_Dark", spath))


# Check

bkcols <- gsub("Selenized Dark", "OKSolar Dark", bpath) %>%
  readLines() %>%
  c(readLines(gsub("Selenized_Dark", "OKSolar_Dark", spath))) %>%
  paste(collapse = "") %>%
  str_split("#") %>%
  map(str_sub, end = 6) %>%
  unlist() %>%
  paste0("#", .)

bkcols[!bkcols %in% tb$oksolar_dark_spec]

gsub("Selenized_Dark", "OKSolar_Dark", spath) %>% source()

rstudioapi::applyTheme("OKSolar Dark")
rstudioapi::applyTheme("Selenized Dark")

# Create Light -----
ncols <- seq_len(nrow(tb))
rs_bk <- rs

for (i in ncols) {
  rs_bk <- gsub(tb$dark_spec[i], tb$oksolar_light_spec[i], rs_bk, ignore.case = TRUE)
}

rs_bk <- gsub("Selenized Dark", "OkSolar Light", rs_bk)
rs_bk <- gsub("selenized_dark", "oksolar_light", rs_bk)
rs_bk <- gsub("theme.dark", "theme.light", rs_bk)
rs_bk == rs
rs_bk %>%
  writeLines(gsub("Selenized Dark", "OkSolar Light", bpath))

# Same with the script
sf_bk <- sf

for (i in ncols) {
  sf_bk <- gsub(tb$dark_spec[i], tb$oksolar_light_spec[i], sf_bk, ignore.case = TRUE)
}

sf_bk <- gsub("Selenized Dark", "OkSolar Light", sf_bk)
sf_bk <- gsub("selenized_dark", "oksolar_light", sf_bk)
sf_bk == sf
sf_bk %>%
  writeLines(gsub("Selenized_Dark", "OkSolar_Light", spath))


# Check

bkcols <- gsub("Selenized Dark", "OkSolar Light", bpath) %>%
  readLines() %>%
  c(readLines(gsub("Selenized_Dark", "OkSolar_Light", spath))) %>%
  paste(collapse = "") %>%
  str_split("#") %>%
  map(str_sub, end = 6) %>%
  unlist() %>%
  paste0("#", .)

bkcols[!bkcols %in% tb$oksolar_light_spec]

gsub("Selenized_Dark", "OkSolar_Light", spath) %>% source()




# Final check
rstudioapi::applyTheme("OKSolar Dark")

aa <- rstudioapi::getThemes()
aa[grepl("OKSo", names(aa), ignore.case = TRUE)]


