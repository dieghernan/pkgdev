check_rd_hash <- function(pkg = ".") {
  path <- file.path(pkg, "man")
  # List files
  allman <- list.files(path, pattern = ".Rd", full.names = TRUE)

  if (length(allman) == 0) {
    cli::cli_alert_info("No {.var .Rd} files found in {.file path}")
    return(NULL)
  }

  # Extract titles, etc.

  allf <- lapply(allman, function(x) {
    lns <- readLines(x)
    getti <- grepl("#'", lns, fixed = TRUE)

    data.frame(
      src = x,
      bad_hash = any(getti)
    )
  })

  enddf <- do.call("rbind", allf)
  enddf
}
