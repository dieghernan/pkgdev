#' Precompute vignettes
#'
#' Precompute vignettes using the CRAN approach, based on
#' <https://ropensci.org/blog/2019/12/08/precompute-vignettes/>.
#'
#' @rdname precompute
#'
#' @details
#' This function searches for the desired precomputed vignette in the
#' `"./vignettes/"` directory and for plots in the root `"./"` directory.
#'
#' ## Important
#' In your `.Rmd.orig` or `.qmd.orig` file, make sure you have set at least the
#' following lines if you are producing plots:
#' ```r
#' knitr::opts_chunk$set(
#'   ...,
#'   fig.path = "./",
#'   ...,
#' )
#'
#' ```
#'
#' @param source Name of the `.Rmd.orig` or `.qmd.orig` file, without the path
#'   (e.g. `"some_name.Rmd.orig"` or `"some_name.qmd.orig"`).
#' @param figure_ext Extension of the figures plotted in the vignette.
#'   See **Details**.
#' @param create_r_file Whether to create an additional \R script with the code
#'   of the vignette.
#' @param ... Parameters passed to [precompute_vignette()].
#' @inheritParams update_docs
#'
#' @return Invisibly returns `NULL` after writing a precomputed vignette.
#'
#' @seealso
#' - [build_qmd()] builds Quarto files.
#' - [build_readme_qmd()] builds `README.qmd` files.
#'
#' @source Based on
#'   <https://ropensci.org/blog/2019/12/08/precompute-vignettes/>.
#'
#' @family renderers
#'
#' @export
#' @encoding UTF-8
#'
#' @examples
#' \dontrun{
#' precompute_vignette(source = "precompute.Rmd.orig")
#' }
precompute_vignette <- function(
  source,
  pkg = ".",
  figure_ext = ".png",
  create_r_file = FALSE
) {
  # Use the pkgdown and devtools approach.
  pkg_build <- devtools::as.package(pkg)

  withr::with_temp_libpaths(code = {
    devtools::install(
      pkg_build,
      upgrade = FALSE,
      reload = FALSE,
      quick = TRUE,
      quiet = TRUE
    )

    nm <- pkg_build$package

    # nolint start
    ver <- packageVersion(nm)
    # nolint end
    cli::cli_inform(c(
      i = "Installed {.pkg {nm}} {.strong v{ver}} in temporary library"
    ))

    for (f_path in source) {
      src_path <- file.path(pkg, "vignettes", f_path)
      out <- gsub(".orig", "", src_path)

      cli::cli_alert_info("Precomputing vignette {.file {src_path}}.")

      knitr::knit(input = src_path, output = out, quiet = TRUE)

      perl_path <- gsub("^\\./", "", src_path)
      usethis::use_build_ignore(perl_path)
      if (grepl("qmd$", out)) {
        usethis::use_git_ignore("**/.quarto/", directory = pkg)
        usethis::use_git_ignore(
          "*_files",
          directory = file.path(pkg, "vignettes")
        )
        usethis::use_build_ignore("vignettes/*_files")
      }
      usethis::use_git_ignore(
        c("*.html", "*.R"),
        directory = file.path(pkg, "vignettes")
      )

      cli::cli_alert_success("Wrote precomputed vignette {.file {out}}.")

      # Move plot files to the vignette directory.
      plots <- list.files(pkg, pattern = figure_ext)
      plots_to_move <- file.path(pkg, "vignettes", plots)

      file.copy(plots, plots_to_move, overwrite = TRUE)
      file.remove(plots)

      # Create an R file.
      if (create_r_file) {
        r_file <- gsub(".Rmd|.qmd", ".R", out)
        knitr::purl(src_path, output = r_file)
      }

      # Clean up generated files.
      dir_clean <- gsub(".Rmd|.qmd", "_files/", out)
      unlink(dir_clean, force = TRUE, recursive = TRUE)
      html_clean <- gsub(".Rmd|.qmd", ".html", out)
      unlink(html_clean, force = TRUE, recursive = TRUE)

      ff <- list.files(file.path(pkg, "vignettes"), full.names = TRUE)

      ff[grepl("_quarto.yaml|_quarto.yml", ff)] |>
        unlink(recursive = TRUE, force = TRUE)
    }
  })

  invisible()
}

#' @rdname precompute
#' @param dir Path to the directory where the `.Rmd.orig` and `.qmd.orig` files
#'   are stored.
#'
#' @export
#' @encoding UTF-8
#'
precompute_vignette_all <- function(dir = "vignettes", pkg = ".", ...) {
  vignette_list <- list.files(file.path(pkg, dir))

  find_vignettes <- grep(".Rmd.orig$|.qmd.orig$", vignette_list)
  if (length(find_vignettes) > 0) {
    vig <- vignette_list[find_vignettes]
    precompute_vignette(source = vig, pkg = pkg, ...)
  } else {
    cli::cli_alert_info(
      c(
        "No {.file .Rmd.orig} or {.file .qmd.orig} vignettes found in ",
        "{.path {file.path(pkg, dir)}}."
      )
    )
  }
}
