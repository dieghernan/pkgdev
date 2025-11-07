tm_path <- "data-raw/oldthemes/Selenized Light.tmTheme"

rstudioapi::convertTheme(
  tm_path,
  add = FALSE,
  outputLocation = "data-raw/oldthemes/",
  force = TRUE
)

# Modify cursor
cursor_col <- "#3A4D53"
rtheme <- gsub(".tmTheme", ".rstheme", tm_path)

tm <- readLines(rtheme)

# Find line with cursor
curs_lin <- grep("ace_cursor", tm)
tm[curs_lin + 1] <- paste0("  color: ", cursor_col, ";")

# Add rules (css inside)
tem_lin <- grep("terminal", tm)[1]
pre_tem <- tm[seq(1, tem_lin - 1)]
pos_tem <- tm[seq(tem_lin, length(tm))]

# Insert
head_col <- "#A78300"
newl <- c(
  ".ace_heading, .ace_markup.ace_heading, .ace_meta.ace_tag {",
  paste0("  color: ", head_col, ";"),
  "}"
)
pre_tem <- c(pre_tem, newl)

# Code fence
code_col <- "#0072D4"
cod_css <- c(
  ".ace_support.ace_function {",
  paste0("  color: ", code_col, ";"),
  "}"
)

pre_tem <- c(pre_tem, cod_css)
final_tm <- c(pre_tem, pos_tem)

sass::sass(final_tm, output = rtheme)
