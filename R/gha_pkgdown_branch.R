#' Create a GitHub action that builds a pkgdown site
#'
#' @description
#' The GitHub action created would deploy a pkgdown site of your package
#' on the gh-pages branch.
#'
#'
#' @param platform	Platform to use for deploying the package. See **Details**
#' @param version Version of the platform. See **Details**.
#' @inheritParams gha_check_full
#'
#' @details
#' Check <https://github.com/actions/runner-images> to see the available
#' options.
#'
#'
#' @seealso [gha_check_full()]
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
#' # With Ubuntu 20.04
#' gha_pkgdown_branch(platform = "ubuntu", version = "20.04")
#' }
#'
gha_pkgdown_branch <-
  function(pkg = ".",
           overwrite = TRUE,
           platform = "macOS",
           version = "latest") {
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
    usethis::use_git_ignore("R-version",
      directory = file.path(pkg, ".github")
    )
    usethis::use_git_ignore("depends.Rds",
      directory = file.path(pkg, ".github")
    )
    usethis::use_git_ignore("*.html",
      directory = file.path(pkg, ".github")
    )


    # Get action file
    filepath <-
      system.file("yaml/pkgdown-gh-pages.yaml", package = "pkgdev")

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
    add_platform <- readLines(file.path(destdir, "pkgdown-gh-pages.yaml"))

    add_platform <- gsub(
      pattern = "<OS>",
      replacement = platform,
      x = add_platform
    )

    # Add version
    add_platform <- gsub(
      pattern = "<version>",
      replacement = version,
      x = add_platform
    )

    writeLines(add_platform, con = file.path(destdir, "pkgdown-gh-pages.yaml"))
    cli::cli_alert_info(paste(
      "Your package would be deployed on",
      "{.val {paste0(platform, '-', version)}}"
    ))

    return(invisible())
  }
