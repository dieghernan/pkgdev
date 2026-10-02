#' Create a GitHub Actions workflow that builds a \CRANpkg{pkgdown} site
#'
#' @description
#' The GitHub Actions workflow deploys a \CRANpkg{pkgdown} site for your
#' package to the `gh-pages` branch.
#'
#' @details
#' Check <https://github.com/actions/runner-images> to see the available
#' options.
#'
#' @param platform Runner operating system to use for deploying the site.
#'   See **Details**.
#' @param version Runner image version. See **Details**.
#' @inheritParams update_docs
#' @inheritParams gha_check_full
#'
#' @inherit gha_check_full return source
#'
#' @seealso [pkgdown::build_site()] builds the package website locally.
#'
#' @family actions
#'
#' @export
#' @encoding UTF-8
#'
#' @examples
#' \dontrun{
#' # With Ubuntu 20.04.
#' gha_pkgdown_branch(platform = "ubuntu", version = "20.04")
#' }
gha_pkgdown_branch <- function(
  pkg = ".",
  overwrite = TRUE,
  platform = "macOS",
  version = "latest"
) {
  # Check destination directory.
  destdir <- file.path(pkg, ".github", "workflows")
  checkdir <- dir.exists(destdir)
  if (isFALSE(checkdir)) {
    dir.create(destdir, recursive = TRUE)
  }

  # Add files to build ignore.
  use_build_ignore_dir(".github")
  usethis::use_build_ignore("_pkgdown.yaml")
  usethis::use_build_ignore("_pkgdown.yml")

  # Ignore folders.
  use_build_ignore_dir(c("pkgdown", "docs"))
  usethis::use_git_ignore("docs/", pkg)

  # Add files to `.gitignore`.
  usethis::use_git_ignore("R-version", directory = file.path(pkg, ".github"))
  usethis::use_git_ignore("depends.Rds", directory = file.path(pkg, ".github"))
  usethis::use_git_ignore("*.html", directory = file.path(pkg, ".github"))

  # Get action file.
  filepath <- system.file("yaml/pkgdown-gh-pages.yaml", package = "pkgdev")
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

  # Add platform.
  add_platform <- readLines(workflow)

  add_platform <- gsub(
    pattern = "<OS>",
    replacement = platform,
    x = add_platform,
    fixed = TRUE
  )

  # Add version.
  add_platform <- gsub(
    pattern = "<version>",
    replacement = version,
    x = add_platform,
    fixed = TRUE
  )

  writeLines(add_platform, con = workflow)
  cli::cli_alert_success(
    "Updated GitHub Actions workflow {.file {workflow}}."
  )
  cli::cli_alert_info(
    "Configured deployment runner {.val {paste0(platform, '-', version)}}."
  )

  invisible()
}
