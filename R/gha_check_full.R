#' Create a GitHub Actions workflow that checks your package regularly
#'
#' The GitHub Actions workflow runs `R CMD check` on your package.
#' It uses a wide range of platforms, which can be reduced by commenting out or
#' deleting platforms in the matrix configuration.
#'
#' @details
#' Use [crontab.guru](https://crontab.guru/#30_08_1_*_*) to check and
#' create your own cron tag.
#'
#' @param overwrite Overwrite the action if it was already present.
#' @param cron_expr Valid cron expression. By default, the first day of the
#'   month at 08:30 AM. See **Details**.
#' @inheritParams update_docs
#'
#' @return Invisibly returns `NULL` after writing a GitHub Actions workflow to
#'   `<pkg>/.github/workflows`.
#'
#' @seealso
#' - [gha_pkgdown_branch()] creates a \CRANpkg{pkgdown} deployment action.
#' - [gha_update_docs()] creates a documentation and deployment action.
#' - [usethis::use_github_action()] creates GitHub Actions workflows.
#'
#' @source Examples from
#'   [r-lib/actions](https://github.com/r-lib/actions/tree/master/examples).
#'
#' @family actions
#'
#' @export
#' @encoding UTF-8
#'
#' @examples
#' \dontrun{
#' gha_check_full(cron_expr = "57 16 12 * *")
#' }
gha_check_full <- function(
  pkg = ".",
  overwrite = TRUE,
  cron_expr = "30 08 1 * *"
) {
  # Check destination directory.
  destdir <- file.path(pkg, ".github", "workflows")
  checkdir <- dir.exists(destdir)
  if (isFALSE(checkdir)) {
    dir.create(destdir, recursive = TRUE)
  }

  # Add files to build ignore.
  use_build_ignore_dir(".github")

  # Add files to git ignore.
  usethis::use_git_ignore("R-version", directory = file.path(pkg, ".github"))
  usethis::use_git_ignore("depends.Rds", directory = file.path(pkg, ".github"))
  usethis::use_git_ignore("*.html", directory = file.path(pkg, ".github"))

  # Get action file.
  filepath <- system.file("yaml/check-full.yaml", package = "pkgdev")
  workflow <- file.path(destdir, basename(filepath))

  # Copy action file.
  result <- file.copy(filepath, destdir, overwrite = overwrite)

  if (result) {
    cli::cli_alert_success(
      "Updated GitHub Actions workflow {.file {workflow}}."
    )
  } else {
    cli::cli_alert_danger(
      "Could not update GitHub Actions workflow {.file {workflow}}."
    )
    return(invisible())
  }

  # Add CRON expression.
  add_cron <- readLines(workflow)
  add_cron <- gsub(
    pattern = "ADD_CRON_EXPRESSION",
    replacement = cron_expr,
    x = add_cron,
    fixed = TRUE
  )

  writeLines(add_cron, con = workflow)

  invisible()
}
