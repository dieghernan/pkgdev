nm <- "Selenized White"
dark <- FALSE
path <- file.path("inst/themes", nm) %>% paste0(".rstheme")

rsthemes::rstheme(
  theme_name = nm,
  theme_path = path,
  ui_background = "#FFFFFF",
  ui_foreground = "#474747",
  code_comment = "#878787",
  code_string = "#00AD9C",
  code_function = "#0064E4",
  code_value = "#00AD9C",
  code_variable = "#0064E4",
  code_message = "#00AD9C",
  code_operator = "#1D9700",
  code_reserved = "#1D9700",
  theme_dark = dark,
  theme_palette = list(
    red = "#D6000C",
    green = "#1D9700",
    yellow = "#C49700",
    blue = "#0064E4",
    magenta = "#DD0F9D",
    cyan = "#00AD9C",
    orange = "#D04A00",
    violet = "#7F51D6"
  ),
  ui_cursor = "#474747",
  ui_selection = "#CDCDCD",
  rmd_heading_foreground = "#AF8500",
  rmd_chunk_background = "#EBEBEB",
  ui_line_active_gutter = "#CDCDCD",
  ui_invisible = "#EBEBEB",
  theme_apply = FALSE
)

# Modify name
readLines(path) %>%
  str_remove_all(fixed("{rsthemes}")) %>%
  writeLines(path)

rstudioapi::addTheme(path, apply = TRUE, force = TRUE)
