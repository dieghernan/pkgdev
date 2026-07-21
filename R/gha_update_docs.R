#' Create a GitHub Actions workflow that documents and checks your package
#'
#' The GitHub Actions workflow documents your package (see [update_docs()]),
#' checks it and deploys the package on a `gh-pages` branch.
#'
#' @inherit gha_pkgdown_branch details
#'
#' @inheritParams gha_pkgdown_branch
#'
#' @return Invisibly returns `NULL` after writing a GitHub Actions workflow to
#'   `.github/workflows`.
#'
#' @seealso
#' - [update_docs()] documents and checks your package.
#' - [gha_check_full()] creates a full package check action.
#' - [gha_pkgdown_branch()] creates a \CRANpkg{pkgdown} deployment action.
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
#' gha_update_docs(platform = "ubuntu", version = "20.04")
#' }
gha_update_docs <- function(
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
  filepath <- system.file("yaml/update-docs.yaml", package = "pkgdev")
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

  cli::cli_alert_info(
    "Configured deployment runner {.val {paste0(platform, '-', version)}}."
  )

  invisible()
}
