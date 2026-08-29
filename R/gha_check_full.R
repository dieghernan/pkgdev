#' Create a GitHub Actions workflow that checks your package regularly
#'
#' The GitHub Actions workflow runs `R CMD check` on your package.
#' It uses a wide range of platforms, which can be reduced by commenting out or
#' deleting platforms in the matrix configuration.
#'
#' @details
#' Use [crontab.guru](https://crontab.guru/#30_08_1_*_*) to check and
#' create your own cron expression.
#'
#' @param overwrite Whether to overwrite an existing action.
#' @param cron_expr A valid cron expression. Defaults to 08:30 AM on the first
#'   day of the month. See **Details**.
#' @inheritParams update_docs
#'
#' @return Invisibly returns `NULL` after writing a GitHub Actions workflow to
#'   `<pkg>/.github/workflows`.
#'
#' @source Examples from
#'   [r-lib/actions](https://github.com/r-lib/actions/tree/master/examples).
#'
#' @seealso [usethis::use_github_action()] creates GitHub Actions workflows.
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

  if (!result) {
    cli::cli_abort(
      c(
        "Could not update GitHub Actions workflow {.file {workflow}}.",
        "i" = if (file.exists(workflow) && !overwrite) {
          "Set {.arg overwrite} to {.val TRUE} to replace the existing file."
        }
      ),
      class = "pkgdev_workflow_copy_error"
    )
  }

  # Add the cron expression.
  add_cron <- readLines(workflow)
  add_cron <- gsub(
    pattern = "ADD_CRON_EXPRESSION",
    replacement = cron_expr,
    x = add_cron,
    fixed = TRUE
  )

  writeLines(add_cron, con = workflow)

  cli::cli_alert_success(
    "Updated GitHub Actions workflow {.file {workflow}}."
  )

  invisible()
}
