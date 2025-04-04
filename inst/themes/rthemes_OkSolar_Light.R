library(tidyverse)

tm_path <- "inst/themes/OkSolar Light.tmTheme"

rstudioapi::convertTheme(tm_path,
                         add = FALSE,
                         outputLocation = "inst/themes/",
                         force = TRUE
)

# Modify some elements ----
cursor_col <- "#093946"
rtheme <- gsub(".tmTheme", ".rstheme", tm_path)

tm <- readLines(rtheme)

curs_lin <- grep("ace_cursor", tm)
tm[curs_lin + 1] <- paste0("color: ", cursor_col, ";")

# Add rules before terminal
tem_lin <- grep("terminal", tm)[1] -1
partial1 <- tm[seq(1, tem_lin)]
partial2 <- tm[seq(tem_lin + 1, length(tm))]

# Insert new rules
head_col <- "#AC8300"
head_css <- paste0(
  ".ace_heading {color: ",
  head_col, ";}")


# Re-generate css and write
final_tm <- c(partial1, head_css, partial2)

final_tm %>%
  sass::sass(output = rtheme)

rstudioapi::addTheme(rtheme, apply = TRUE, force = TRUE)
