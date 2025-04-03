tm_path <- "inst/themes/Selenized Dark.tmTheme"

rstudioapi::convertTheme("inst/themes/Selenized Dark.tmTheme",
                         add = FALSE,
                         outputLocation = "inst/themes/",
                         force = TRUE)

# Modify cursor
cursor_col <- "#84c747"
rtheme <- gsub(".tmTheme", ".rstheme", tm_path)

tm <- readLines(rtheme)

# Find line with cursor
curs_lin <- grep("ace_cursor", tm)
tm[curs_lin + 1] <- paste0("  color: ",cursor_col,";")

# Add rules (css inside)
head_col <- "#ebc13d"
newl <- paste0(".ace_heading, .ace_markup.ace_heading, .ace_meta.ace_tag	 {color:",
               head_col, "; }\n")
# Code fence
code_col <- "#adbcbc"
code_col <- "red"
bg_col <- "#2d5b69"
cod_css <- paste0(".ace_support.ace_function	 {color:",code_col,
                  "; background_color:",bg_col, "; }\n")

tm <- c(tm, newl, cod_css)

writeLines(tm, rtheme)

rstudioapi::addTheme(rtheme, apply = TRUE, force = TRUE)
