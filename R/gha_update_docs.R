#' Create a GitHub action that documents and checks your package
#'
#' @description
#' The GitHub action created would document your package (see [update_docs()]),
#' would check it and would deploy the package on a gh-pages branch.
#'
#'
#' @inheritParams gha_pkgdown_branch
#'
#' @details
#' Check <https://github.com/actions/runner-images> to see the available
#' options.
#'
#'
#' @seealso [update_docs()], [gha_pkgdown_branch()]
#'
#' @source
#' [r-lib/actions](https://github.com/r-lib/actions/tree/master/examples)
#'
#'
#' @export
#'
#' @return A GitHub Action on `.github/workflows`.
#'
#' @examples
#' \dontrun{
#' # With Ubuntu 20.04
#' gha_update_docs(platform = "ubuntu", version = "20.04")
#' }
#'
gha_update_docs <-
  function(
    pkg = ".",
    overwrite = TRUE,
    platform = "macOS",
    version = "latest"
  ) {
    # Check destdir

    destdir <- file.path(pkg, ".github", "workflows")
    checkdir <- dir.exists(destdir)
    if (isFALSE(checkdir)) {
      dir.create(destdir, recursive = TRUE)
    }

    # Add files to build ignore
    usethis::use_build_ignore(".github")
    usethis::use_build_ignore("_pkgdown.yaml")
    usethis::use_build_ignore("_pkgdown.yml")

    # Ignore folders
    usethis::use_build_ignore("pkgdown")
    usethis::use_build_ignore("docs")
    usethis::use_git_ignore("docs/", pkg)

    # Add files to git ignore
    usethis::use_git_ignore("R-version", directory = file.path(pkg, ".github"))
    usethis::use_git_ignore(
      "depends.Rds",
      directory = file.path(pkg, ".github")
    )
    usethis::use_git_ignore("*.html", directory = file.path(pkg, ".github"))

    # Get action file
    filepath <- system.file("yaml/update-docs.yaml", package = "pkgdev")

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

    # Add platform
    add_platform <- readLines(file.path(destdir, "update-docs.yaml"))

    add_platform <- gsub(
      pattern = "<OS>",
      replacement = platform,
      x = add_platform,
      fixed = TRUE
    )

    # Add version
    add_platform <- gsub(
      pattern = "<version>",
      replacement = version,
      x = add_platform,
      fixed = TRUE
    )

    writeLines(add_platform, con = file.path(destdir, "update-docs.yaml"))

    cli::cli_alert_info(paste(
      "Your package would be deployed on",
      "{.val {paste0(platform, '-', version)}}"
    ))

    invisible()
  }
