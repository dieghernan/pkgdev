#' Check the titles of a Rd file
#'
#'
#' Check if title of Rd files ends in a period.
#'
#' @inheritParams update_docs
#'
#' @return A data frame with the results.
#'
#' @examples
#' \dontrun{
#'
#' check_rd_titles()
#' }
#'
#' @export
check_rd_titles <- function(pkg = ".") {
  path <- file.path(pkg, "man")
  # List files
  allman <- list.files(path,
    pattern = ".Rd",
    full.names = TRUE
  )

  if (length(allman) == 0) {
    cli::cli_alert_info("No {.var .Rd} files found in {.file path}")
    return(NULL)
  }

  # Extract titles, etc.

  allf <- lapply(allman, function(x) {
    lns <- readLines(x)
    getti <- lns[grepl("\\\\title", lns)]
    tomd <- roxygen2md::markdownify(getti)
    # Clean
    tit <- gsub("^(.*)title\\{|\\}$", "", tomd)
    tosent <- stringr::str_to_sentence(tit)
    last <- substr(tit, nchar(tit), nchar(tit) + 10)

    data.frame(
      src = x,
      title = tit,
      tosent = tosent,
      last = last
    )
  })


  enddf <- do.call("rbind", allf)
  enddf$check_case <- enddf$title == enddf$tosent

  enddf
}
