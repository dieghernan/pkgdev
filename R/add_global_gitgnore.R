#' Add `.gitignore` to package
#'
#' Adds a global `.gitignore` file to the package. The file is based on the
#' default `.gitignore` provided by GitHub.
#'
#' @inheritParams update_docs
#'
#' @return Invisibly returns `NULL` after writing a global `.gitignore` file.
#'
#' @seealso
#' - [update_docs()] runs package maintenance tasks that call
#'   `add_global_gitgnore()`.
#' - [usethis::use_git_ignore()] adds entries to `.gitignore`.
#' - [usethis::git_vaccinate()] adds global Git ignore rules.
#'
#' @family maintenance
#'
#' @export
#' @encoding UTF-8
#'
#' @examples
#' \dontrun{
#' add_global_gitgnore()
#' }
add_global_gitgnore <- function(pkg = ".") {
  # Template from GitHub.
  # History files.
  add_global_use_git_ignore(".Rproj.user", directory = pkg)

  add_global_use_git_ignore(".Rhistory", directory = pkg)
  add_global_use_git_ignore(".Rapp.history", directory = pkg)

  # Session data files.
  add_global_use_git_ignore(".RData", directory = pkg)
  # Session data files.
  add_global_use_git_ignore(".Rdata", directory = pkg)

  # User-specific files.
  add_global_use_git_ignore(".Ruserdata", directory = pkg)

  # Example code in package build process.
  add_global_use_git_ignore("*-Ex.R", directory = pkg)

  # Output files from R CMD build.
  add_global_use_git_ignore("/*.tar.gz", directory = pkg)

  # Output files from R CMD check.
  add_global_use_git_ignore("/*.Rcheck/", directory = pkg)

  # RStudio files.
  add_global_use_git_ignore(".Rproj.user/", directory = pkg)

  # Produced vignettes.
  add_global_use_git_ignore("vignettes/*.html", directory = pkg)
  add_global_use_git_ignore("vignettes/*.pdf", directory = pkg)

  # OAuth2 token, see https://github.com/hadley/httr/releases/tag/v0.3.
  add_global_use_git_ignore(".httr-oauth", directory = pkg)

  # knitr and R Markdown default cache directories.
  add_global_use_git_ignore("*_cache/", directory = pkg)
  add_global_use_git_ignore("/cache/", directory = pkg)

  # Temporary files created by R Markdown.
  add_global_use_git_ignore("*.utf8.md", directory = pkg)
  add_global_use_git_ignore("*.knit.md", directory = pkg)

  # R environment variables.
  add_global_use_git_ignore(".Renviron", directory = pkg)

  add_global_use_git_ignore(".positai", directory = pkg)

  # Vaccinate.
  add_global_git_vaccinate()

  # Revdep.
  # Clean up previous versions.
  f <- readLines(".gitignore")
  fnew <- f[f != "revdep"]
  writeLines(fnew, ".gitignore")

  if (dir.exists(file.path(pkg, "revdep"))) {
    revdepig <- c(
      "checks",
      "library",
      "checks.noindex",
      "library.noindex",
      "data.sqlite",
      "*.html"
    )

    add_global_use_git_ignore(revdepig, directory = file.path(pkg, "revdep"))
  }

  # Ignore this on build too.
  use_build_ignore_dir("revdep")

  # Codemeta.

  add_global_use_build_ignore("codemeta.json")
  add_global_use_build_ignore("CITATION.cff")

  # Extra ignores.
  pkgname <- add_global_as_package(pkg)$package
  add_global_use_git_ignore(paste0(pkgname, ".Rcheck/"), directory = pkg)
  add_global_use_git_ignore(paste0(pkgname, "*.tar.gz"), directory = pkg)
  add_global_use_git_ignore(paste0(pkgname, "*.tgz"), directory = pkg)

  add_global_use_build_ignore("CRAN-SUBMISSION")
  add_global_use_git_ignore("CRAN-SUBMISSION", directory = pkg)

  add_global_use_build_ignore("cran-comments.md")
  add_global_use_git_ignore("cran-comments.md", directory = pkg)

  add_global_use_git_ignore(".github/pkg.lock", directory = pkg)
  add_global_use_git_ignore("*.rmarkdown", directory = pkg)

  use_build_ignore_dir("pkgdown")
  add_global_use_build_ignore("pkgdown.yaml")
  add_global_use_build_ignore("pkgdown.yml")
  add_global_use_build_ignore("_pkgdown.yaml")
  add_global_use_build_ignore("_pkgdown.yml")
  add_global_use_build_ignore("codecov.yml")
  add_global_use_build_ignore(".imgbotconfig")
  add_global_use_build_ignore(".lintr")
  add_global_use_build_ignore("CODE_OF_CONDUCT.md")
  add_global_use_build_ignore("CONTRIBUTING.md")
  use_build_ignore_dir(c("data-raw", ".github", "docs", ".vscode", "dev"))

  # PDF plots.
  add_global_use_git_ignore("Rplots.pdf", directory = pkg)
  add_global_use_build_ignore("Rplots.pdf")

  # jarl.
  add_global_use_build_ignore("jarl.toml")

  # Positron and Quarto.
  add_global_use_git_ignore(
    c("/.quarto/", "**/*.quarto_ipynb"),
    directory = pkg
  )

  use_build_ignore_dir(".quarto")
  add_global_use_build_ignore("[.]quarto_ipynb$", escape = FALSE)
  add_global_use_build_ignore("[.]markdown$", escape = FALSE)

  use_build_ignore_dir(c(
    "vignettes/.quarto",
    "vignettes/articles/.quarto",
    "vignettes/articles"
  ))
  add_global_use_build_ignore(c(
    "vignettes/_quarto.yaml",
    "vignettes/_quarto.yml",
    "vignettes/articles/*_files",
    ".gitattributes"
  ))

  use_build_ignore_dir(c(".positai", ".claude", ".codex"))

  add_global_use_build_ignore(c(
    "index.qmd",
    "index.html",
    "index.md"
  ))
  use_build_ignore_dir("index_files")
  add_global_use_git_ignore(c("index_files/", "*index.html", "pkgdown/*_files"))

  # Ignore Quarto articles and vignettes.
  pth <- file.path(pkg, "vignettes")

  if (length(list.files(pth, pattern = "qmd$")) > 0) {
    add_global_use_git_ignore(
      c(
        "/.quarto/",
        "*_files",
        "*.rmarkdown",
        "*.html",
        "*.R",
        "_quarto.yaml",
        "_quarto.yml"
      ),
      directory = pth
    )
  }

  pth <- file.path(pkg, "vignettes", "articles")

  if (length(list.files(pth, pattern = "qmd$")) > 0) {
    add_global_use_git_ignore(
      c(
        "/.quarto/",
        "*_files",
        "*.rmarkdown",
        "*.html",
        "*.R",
        "_quarto.yaml",
        "_quarto.yml"
      ),
      directory = pth
    )
  }

  invisible()
}

add_global_use_git_ignore <- function(...) {
  usethis::use_git_ignore(...)
}

add_global_git_vaccinate <- function(...) {
  usethis::git_vaccinate(...)
}

add_global_use_build_ignore <- function(...) {
  usethis::use_build_ignore(...)
}

add_global_as_package <- function(...) {
  devtools::as.package(...)
}
