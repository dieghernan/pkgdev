library(tidyverse)

nm <- "Selenized Dark"
dark <- TRUE
path <- file.path("inst/themes", nm) %>% paste0(".rstheme")

rsthemes::rstheme(
  theme_name = nm,
  theme_path = path,
  ui_background = "#103C48",
  ui_foreground = "#ADBCBC",
  code_comment = "#72898F",
  code_string = "#41C7B9",
  code_function = "#4695F7",
  code_value = "#41C7B9",
  code_variable = "#4695F7",
  code_message = "#41C7B9",
  code_operator = "#75B938",
  code_reserved = "#75B938",
  theme_dark = dark,
  theme_palette = list(
    red = "#FA5750",
    green = "#75B938",
    yellow = "#DBB32D",
    blue = "#4695F7",
    magenta = "#F275BE",
    cyan = "#41C7B9",
    orange = "#ED8649",
    violet = "#AF88EB"
  ),
  ui_cursor = "#ADBCBC",
  ui_selection = "#2D5B69",
  rmd_heading_foreground = "#EBC13D",
  rmd_chunk_background = "#184956",
  ui_line_active_gutter = "#2D5B69",
  ui_invisible = "#184956",
  theme_apply = FALSE
)

# Modify name
readLines(path) %>%
  str_remove_all(fixed("{rsthemes}")) %>%
  writeLines(path)

rstudioapi::addTheme(path, apply = TRUE, force = TRUE)
