nm <- "Selenized Black"
dark <- TRUE
path <- file.path("inst/themes", nm) %>%  paste0(".rstheme")

rsthemes::rstheme(
  theme_name = nm,
  theme_path = path,
  ui_background = "#181818",
  ui_foreground = "#B9B9B9",
  code_comment = "#777777",
  code_string = "#3FC5B7",
  code_function = "#368AEB",
  code_value = "#3FC5B7",
  code_variable = "#368AEB",
  code_message = "#3FC5B7",
  code_operator = "#70B433",
  code_reserved = "#70B433",
  theme_dark = dark,
  theme_palette = list(
    red = "#ED4A46",
    green = "#70B433",
    yellow = "#DBB32D",
    blue = "#368AEB",
    magenta = "#EB6EB7",
    cyan = "#3FC5B7",
    orange = "#E67F43",
    violet = "#A580E2"
  ),
  ui_cursor = "#B9B9B9",
  ui_selection = "#3B3B3B",
  rmd_heading_foreground = "#EFC541",
  rmd_chunk_background = "#252525",
  ui_line_active_gutter = "#3B3B3B",
  ui_invisible = "#252525",
  theme_apply = FALSE
)

# Modify name
readLines(path) %>%
  str_remove_all(fixed("{rsthemes}")) %>%
  writeLines(path)

rstudioapi::addTheme(path, apply = TRUE, force = TRUE)

