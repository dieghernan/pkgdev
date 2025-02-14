#' Add `.gitignore` to package
#'
#' @description
#' Adds a global `.gitgnore` file to the package. File based on default
#' `.gitignore` provided by GitHub.
#'
#' @inheritParams update_docs
#'
#' @export
#'
#' @seealso [usethis::use_git_ignore()], [usethis::git_vaccinate()]
#'
#' @return Invisible, and writes a global `.gitignore` file
#'
#' @examples
#' \dontrun{
#' add_global_gitgnore()
#' }
#'
add_global_gitgnore <- function(pkg = ".") {
  # Template from Github
  # History files
  usethis::use_git_ignore(".Rproj.user", directory = pkg)

  usethis::use_git_ignore(".Rhistory", directory = pkg)
  usethis::use_git_ignore(".Rapp.history", directory = pkg)

  # Session Data files
  usethis::use_git_ignore(".RData", directory = pkg)
  # Session Data files
  usethis::use_git_ignore(".Rdata", directory = pkg)

  # User-specific files
  usethis::use_git_ignore(".Ruserdata", directory = pkg)

  # Example code in package build process
  usethis::use_git_ignore("*-Ex.R", directory = pkg)

  # Output files from R CMD build
  usethis::use_git_ignore("/*.tar.gz", directory = pkg)

  # Output files from R CMD check
  usethis::use_git_ignore("/*.Rcheck/", directory = pkg)

  # RStudio files
  usethis::use_git_ignore(".Rproj.user/", directory = pkg)

  # produced vignettes
  usethis::use_git_ignore("vignettes/*.html", directory = pkg)
  usethis::use_git_ignore("vignettes/*.pdf", directory = pkg)

  # OAuth2 token, see https://github.com/hadley/httr/releases/tag/v0.3
  usethis::use_git_ignore(".httr-oauth", directory = pkg)

  # knitr and R markdown default cache directories
  usethis::use_git_ignore("*_cache/", directory = pkg)
  usethis::use_git_ignore("/cache/", directory = pkg)

  # Temporary files created by R markdown
  usethis::use_git_ignore("*.utf8.md", directory = pkg)
  usethis::use_git_ignore("*.knit.md", directory = pkg)

  # R Environment Variables
  usethis::use_git_ignore(".Renviron", directory = pkg)

  # Vaccinate
  usethis::git_vaccinate()

  # Revdep
  # Cleanup previous versions
  f <- readLines(".gitignore")
  fnew <- f[f != "revdep"]
  writeLines(fnew, ".gitignore")

  if (dir.exists(file.path(pkg, "revdep"))) {
    revdepig <- c(
      "checks", "library", "checks.noindex", "library.noindex",
      "data.sqlite", "*.html"
    )

    usethis::use_git_ignore(revdepig, directory = file.path(pkg, "revdep"))
  }

  # Ignore this also on build
  usethis::use_build_ignore("revdep")


  # Codemeta

  usethis::use_build_ignore("codemeta.json")
  usethis::use_build_ignore("CITATION.cff")

  # Extra ignores
  pkgname <- devtools::as.package(pkg)$package
  usethis::use_git_ignore(paste0(pkgname, ".Rcheck/"), directory = pkg)
  usethis::use_git_ignore(paste0(pkgname, "*.tar.gz"), directory = pkg)
  usethis::use_git_ignore(paste0(pkgname, "*.tgz"), directory = pkg)

  usethis::use_build_ignore("CRAN-SUBMISSION")
  usethis::use_git_ignore("CRAN-SUBMISSION", directory = pkg)

  usethis::use_build_ignore("cran-comments.md")
  usethis::use_git_ignore("cran-comments.md", directory = pkg)

  usethis::use_git_ignore(".github/pkg.lock", directory = pkg)

  usethis::use_build_ignore("pkgdown")
  usethis::use_build_ignore("pkgdown.yaml")
  usethis::use_build_ignore("pkgdown.yml")
  usethis::use_build_ignore("_pkgdown.yaml")
  usethis::use_build_ignore("_pkgdown.yml")
  usethis::use_build_ignore("codecov.yml")
  usethis::use_build_ignore(".imgbotconfig")
  usethis::use_build_ignore(".lintr")
  usethis::use_build_ignore("CODE_OF_CONDUCT.md")
  usethis::use_build_ignore("CONTRIBUTING.md")
  usethis::use_build_ignore(".github")
  usethis::use_build_ignore("docs")


  # PDF on plots
  usethis::use_git_ignore("Rplots.pdf", directory = pkg)
  usethis::use_build_ignore("Rplots.pdf")

  return(invisible())
}
