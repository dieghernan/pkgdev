use_build_ignore_dir <- function(paths) {
  paths <- gsub("\\\\", "/", paths)
  paths <- sub("/+$", "", paths)

  usethis::use_build_ignore(paths)
  usethis::use_build_ignore(
    paste0(sub("\\$$", "", utils::glob2rx(paths)), "/"),
    escape = FALSE
  )

  invisible()
}
