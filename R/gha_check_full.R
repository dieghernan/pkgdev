#' Create a GitHub action that checks regularly your package
#'
#' @description
#' The GitHub action created would run `R CMD check` on your package.
#' It uses a wide range of platforms, can be reduced by commenting or deleting
#' platforms on the matrix config.
#'
#'
#' @param overwrite	Overwrite the action if it was already present.
#' @param cron_expr Valid cron expression. By default, the first
#'   day of the month at 08:30 AM. See **Details**.
#' @inheritParams update_docs
#'
#' @details
#' Use [crontab.guru](https://crontab.guru/#30_08_1_*_*) to check and
#' create your own cron tag.
#'
#'
#' @seealso [usethis::use_github_action()]
#'
#' @source
#' [r-lib/actions](https://github.com/r-lib/actions/tree/master/examples)
#'
#'
#' @export
#'
#' @return A GitHub Action on `<pkg>/.github/workflows`.
#'
#' @examples
#' \dontrun{
#' gha_check_full(cron_expr = "57 16 12 * *")
#' }
#'
gha_check_full <-
  function(pkg = ".", overwrite = TRUE, cron_expr = "30 08 1 * *") {
    # Check destdir

    destdir <- file.path(pkg, ".github", "workflows")
    checkdir <- dir.exists(destdir)
    if (isFALSE(checkdir)) {
      dir.create(destdir, recursive = TRUE)
    }

    # Add files to build ignore
    usethis::use_build_ignore(".github")

    # Add files to git ignore
    usethis::use_git_ignore("R-version", directory = file.path(pkg, ".github"))
    usethis::use_git_ignore(
      "depends.Rds",
      directory = file.path(pkg, ".github")
    )
    usethis::use_git_ignore("*.html", directory = file.path(pkg, ".github"))

    # Get action file
    filepath <-
      system.file("yaml/check-full.yaml", package = "pkgdev")

    # Copy
    result <- file.copy(filepath, destdir, overwrite = overwrite)

    if (result) {
      cli::cli_alert_success(paste(
        cli::col_green("Action updated correctly."),
        "See {.file {file.path(destdir, basename(filepath))}}"
      ))
    } else {
      cli::cli_alert_danger(cli::col_red("File not updated"))
      return(invisible())
    }

    # Add CRON
    add_cron <- readLines(file.path(destdir, "check-full.yaml"))
    add_cron <- gsub(
      pattern = "ADD_CRON_EXPRESSION",
      replacement = cron_expr,
      x = add_cron,
      fixed = TRUE
    )

    writeLines(add_cron, con = file.path(destdir, "check-full.yaml"))

    invisible()
  }
