nm <- "Selenized Light"
dark <- FALSE
path <- file.path("inst/themes", nm) |> paste0(".rstheme")

rsthemes::rstheme(
  theme_name = nm,
  theme_path = path,
  ui_background = "#FBF3DB",
  ui_foreground = "#53676D",
  code_comment = "#909995",
  code_string = "#009C8F",
  code_function = "#0072D4",
  code_value = "#009C8F",
  code_variable = "#0072D4",
  code_message = "#009C8F",
  code_operator = "#489100",
  code_reserved = "#489100",
  theme_dark = dark,
  theme_palette = list(
    red = "#D2212D",
    green = "#489100",
    yellow = "#AD8900",
    blue = "#0072D4",
    magenta = "#CA4898",
    cyan = "#009C8F",
    orange = "#C25D1E",
    violet = "#8762C6"
  ),
  ui_cursor = "#53676D",
  ui_selection = "#D5CDB6",
  rmd_heading_foreground = "#A78300",
  rmd_chunk_background = "#ECE3CC",
  ui_line_active_gutter = "#D5CDB6",
  ui_invisible = "#ECE3CC",
  theme_apply = FALSE
)

# Modify name
readLines(path) |>
  str_remove_all(fixed("{rsthemes}")) |>
  writeLines(path)

rstudioapi::addTheme(path, apply = TRUE, force = TRUE)
