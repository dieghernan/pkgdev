#' Create a GitHub Actions workflow that builds a \CRANpkg{pkgdown} site
#'
#' The GitHub Actions workflow deploys a \CRANpkg{pkgdown} site for your
#' package on the `gh-pages` branch.
#'
#' @details
#' Check <https://github.com/actions/runner-images> to see the available
#' options.
#'
#' @param platform Platform to use for deploying the package. See **Details**.
#' @param version Version of the platform. See **Details**.
#' @inheritParams gha_check_full
#'
#' @return Invisibly returns `NULL` after writing a GitHub Actions workflow to
#'   `<pkg>/.github/workflows`.
#'
#' @seealso
#' - [gha_check_full()] creates a full package check action.
#' - [gha_update_docs()] creates a documentation and deployment action.
#'
#' @inherit gha_check_full source
#'
#' @family actions
#'
#' @export
#' @encoding UTF-8
#'
#' @examples
#' \dontrun{
#' # With Ubuntu 20.04
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

  # Add files to git ignore.
  usethis::use_git_ignore("R-version", directory = file.path(pkg, ".github"))
  usethis::use_git_ignore("depends.Rds", directory = file.path(pkg, ".github"))
  usethis::use_git_ignore("*.html", directory = file.path(pkg, ".github"))

  # Get action file.
  filepath <- system.file("yaml/pkgdown-gh-pages.yaml", package = "pkgdev")

  # Copy action file.
  result <- file.copy(filepath, destdir, overwrite = overwrite)

  if (result) {
    cli::cli_alert_success(paste0(
      "Action updated correctly. ",
      "See {.file {file.path(destdir, basename(filepath))}}"
    ))
  } else {
    cli::cli_alert_danger("File was not updated.")
    return(invisible())
  }

  # Add platform.
  add_platform <- readLines(file.path(destdir, "pkgdown-gh-pages.yml"))

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

  writeLines(add_platform, con = file.path(destdir, "pkgdown-gh-pages.yml"))
  cli::cli_alert_info(
    "Your package will be deployed on {.val {paste0(platform, '-', version)}}"
  )

  invisible()
}
