#' Build a Quarto files package
#'
#' `build_qmd()` is a wrapper around [quarto::quarto_render()] that first
#' installs a temporary copy of the package, and then renders each .Rmd in a
#' clean R session. `build_readme_qmd()` locates your README.and builds it
#' into a README.md
#'
#' @param files The Quarto files to be rendered.
#' @param ... additional arguments passed to [quarto::quarto_render()].
#' @rdname build_qmd
#' @order 1
#'
#' @inheritParams devtools::build_readme
#' @inheritParams quarto::quarto_render
#'
#' @family functions for rendering documentation
#'
#' @export
#'
#' @seealso [devtools::build_readme()]
#'
build_qmd <- function(files, path = ".", ..., quiet = TRUE) {
  pkg <- devtools::as.package(path)
  paths <- path.expand(files)

  ok <- file.exists(paths)
  if (!all(ok)) {
    cli::cli_abort("Can't find file{?s}: {.path {files[!ok]}}.")
  }
  local_install2(pkg, quiet = TRUE)
  for (path in paths) {
    cli::cli_inform(c(i = "Building {.path {path}}"))

    quarto::quarto_render(input = path, ..., quiet = quiet)
  }
  invisible(TRUE)
}

#' @export
#' @rdname build_qmd
#' @order 2
build_readme_qmd <- function(path = ".", quiet = TRUE, ...) {
  pkg <- devtools::as.package(path)
  regexp <- paste0(file.path(pkg$path), "/(inst/)?readme[.]qmd")

  readme_path <- list.files(
    pkg$path,
    ignore.case = TRUE,
    recursive = TRUE,
    full.names = TRUE
  )

  readme_path <- readme_path[grepl(regexp, readme_path, ignore.case = TRUE)]

  if (length(readme_path) == 0) {
    cli::cli_abort("Can't find {.file README.qmd} or {.file inst/README.qmd}.")
  }
  if (length(readme_path) > 1) {
    cli::cli_abort(
      "Can't have both {.file README.qmd} and {.file inst/README.qmd}."
    )
  }

  usethis::use_build_ignore(
    c("README.qmd", "inst/README.qmd", "README_files/", "README.html")
  )

  usethis::use_git_ignore(c("README_files/", "README.html"), directory = path)

  build_qmd(files = readme_path, path = path, ..., quiet = quiet)
}

devtools::build_readme
