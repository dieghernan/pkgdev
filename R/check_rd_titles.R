#' Inspect Rd file titles
#'
#' Inspect generated Rd file titles for sentence case and trailing periods.
#'
#' @inheritParams update_docs
#'
#' @return A data frame with one row per Rd file and columns for the source
#'   path, title, sentence-case title, final character and sentence-case check.
#'
#' @seealso [update_docs()] runs this check after roxygenizing the package.
#'
#' @family checks
#'
#' @export
#' @encoding UTF-8
#'
#' @examples
#' \dontrun{
#' check_rd_titles()
#' }
check_rd_titles <- function(pkg = ".") {
  path <- file.path(pkg, "man")
  # List files.
  allman <- list.files(path, pattern = ".Rd", full.names = TRUE)

  if (length(allman) == 0) {
    cli::cli_alert_info("No {.file .Rd} files found in {.file {path}}")
    return(NULL)
  }

  # Extract titles.

  allf <- lapply(allman, function(x) {
    lns <- readLines(x)
    getti <- lns[grepl("\\\\title", lns)]
    tomd <- roxygen2md::markdownify(getti)
    # Clean title.
    tit <- gsub("^(.*)title\\{|\\}$", "", tomd)
    tosent <- stringr::str_to_sentence(tit)
    last <- substr(tit, nchar(tit), nchar(tit) + 10)

    data.frame(src = x, title = tit, tosent = tosent, last = last)
  })

  enddf <- do.call("rbind", allf)
  enddf$check_case <- enddf$title == enddf$tosent

  enddf
}
