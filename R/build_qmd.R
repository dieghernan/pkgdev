#' Build Quarto files for a package
#'
#' `build_qmd()` is a wrapper around [quarto::quarto_render()] that first
#' installs a temporary copy of the package, then renders each Quarto file in a
#' clean \R session. `build_readme_qmd()` locates your `README.qmd` and builds
#' it into a `README.md`.
#'
#' @rdname build_qmd
#' @order 1
#'
#' @param files Quarto files to be rendered.
#' @param ... Additional arguments passed to [quarto::quarto_render()].
#' @inheritParams devtools::build_readme
#' @inheritParams quarto::quarto_render
#'
#' @return `TRUE`, invisibly.
#'
#' @seealso
#' - [build_readme_qmd()] builds `README.qmd` files.
#' - [precompute_vignette()] precomputes vignettes.
#' - [devtools::build_readme()] builds `README` files from R Markdown.
#'
#' @family renderers
#'
#' @export
#' @encoding UTF-8
build_qmd <- function(files, path = ".", ..., quiet = TRUE) {
  pkg <- build_qmd_as_package(path)
  paths <- path.expand(files)

  ok <- file.exists(paths)
  if (!all(ok)) {
    missing <- files[!ok] # nolint
    cli::cli_abort(c(
      "Can't find input file.",
      "x" = "Missing: {.path {missing}}"
    ))
  }

  withr::with_temp_libpaths(code = {
    build_qmd_install(
      pkg,
      upgrade = FALSE,
      reload = FALSE,
      quick = TRUE,
      quiet = TRUE
    )
    nm <- pkg$package

    # nolint start
    ver <- build_qmd_package_version(nm)
    # nolint end
    cli::cli_inform(c(
      i = "Installed {.pkg {nm}} {.strong v{ver}} in temporary library"
    ))

    for (path in paths) {
      cli::cli_inform(c(i = "Building {.path {path}}"))

      build_qmd_render(input = path, ..., quiet = quiet)
    }
  })

  invisible(TRUE)
}

#' @rdname build_qmd
#' @order 2
#'
#' @export
#' @encoding UTF-8
build_readme_qmd <- function(path = ".", quiet = TRUE, ...) {
  pkg <- build_qmd_as_package(path)
  regexp <- paste0(file.path(pkg$path), "/(inst/)?readme[.]qmd")

  readme_path <- list.files(
    pkg$path,
    ignore.case = TRUE,
    recursive = TRUE,
    full.names = TRUE
  )

  readme_path <- readme_path[grepl(regexp, readme_path, ignore.case = TRUE)]

  if (length(readme_path) == 0) {
    cli::cli_abort(c(
      "Can't find a Quarto README source file.",
      "i" = "Expected {.file README.qmd} or {.file inst/README.qmd}."
    ))
  }
  if (length(readme_path) > 1) {
    cli::cli_abort(c(
      "Found multiple Quarto README source files.",
      "x" = "Keep only one of {.file README.qmd} or {.file inst/README.qmd}."
    ))
  }

  usethis::use_build_ignore(c(
    "README.qmd",
    "inst/README.qmd",
    "README.html"
  ))
  use_build_ignore_dir("README_files")

  usethis::use_git_ignore(c("README_files/", "README.html"), directory = path)

  build_qmd(files = readme_path, path = path, ..., quiet = quiet)
}

build_qmd_as_package <- function(...) {
  devtools::as.package(...)
}

build_qmd_install <- function(...) {
  devtools::install(...)
}

build_qmd_package_version <- function(...) {
  packageVersion(...)
}

build_qmd_render <- function(...) {
  quarto::quarto_render(...)
}
