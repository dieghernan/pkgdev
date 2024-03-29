#' Precompute vignettes
#'
#' @rdname precompute
#'
#' @description
#' Precompute vignettes from CRAN, based on
#' <https://ropensci.org/blog/2019/12/08/precompute-vignettes/>.
#'
#' @param source Name without path of the `.Rmd.orig` file
#'   (e.g. `"some_name.Rmd.orig"`).
#' @param figure_ext Extension of the figures plotted on the vignette.
#'   See **Details**.
#' @param create_r_file Whether to create an additional R file with the code
#' of the vignette.
#' @param ... Parameters passed to [precompute_vignette()].
#'
#' @inheritParams update_docs
#' @source <https://ropensci.org/blog/2019/12/08/precompute-vignettes/>
#'
#' @details
#' The function would search for the desired precomputed vignette on the
#' `"./vignettes/"` folder and for plots on the root `"./"` folder.
#'
#' ## Important
#' On your `.Rmd.orig` file make sure you have set at least the following
#' lines if you are producing plots:
#' ```r
#' knitr::opts_chunk$set(
#'   ... ,
#'   fig.path = "./",
#'   ... ,
#'   )
#'
#' ````
#' @return A precomputed vignette
#' @examples
#' \dontrun{
#'
#' precompute_vignette(source = "precompute.Rmd.orig")
#' }
#'
#' @export
#'
#'
precompute_vignette <- function(source,
                                pkg = ".",
                                figure_ext = ".png",
                                create_r_file = FALSE) {
  pkg <- devtools::as.package(pkg)
  local_install2(pkg)

  for (f_path in source) {
    src_path <- file.path("vignettes", f_path)
    out <- gsub(".orig", "", src_path)
    usethis::use_build_ignore(src_path)

    cli::cli_alert("Precomputing {.file {src_path}}")
    knitr::knit(input = src_path, output = out, quiet = TRUE)
    cli::cli_alert("Resulting vignette in {.file {out}}")
    # Move plot files to dir

    plots <- list.files(".", pattern = figure_ext)
    plots_to_move <- file.path("vignettes", plots)

    res <- file.copy(plots, plots_to_move, overwrite = TRUE)
    rm(res)
    rem <- file.remove(plots)
    rm(rem)

    # Create R file
    if (create_r_file) {
      r_file <- gsub(".Rmd", ".R", out)
      knitr::purl(src_path, output = r_file)
    }
  }
  return(invisible())
}

#' @rdname precompute
#' @param dir Path to directory where the "Rmd.orig" files
#'   are stored.
#' @export
#'
precompute_vignette_all <- function(dir = "vignettes", pkg = ".", ...) {
  vignette_list <- list.files("vignettes")

  find_vignettes <- grep(".Rmd.orig$", vignette_list)
  if (length(find_vignettes) > 0) {
    vig <- vignette_list[find_vignettes]
    precompute_vignette(source = vig, pkg = pkg, ...)
  } else {
    cli::cli_alert_info(
      "No vignettes for precomputing found in {.path {file.path(dir)}}"
    )
  }
}


# From devtools
local_install2 <- function(pkg = ".", quiet = TRUE, env = parent.frame()) {
  pkg <- devtools::as.package(pkg)

  nm <- pkg$package
  # nolint start
  ver <- packageVersion(nm)
  # nolint end

  cli::cli_inform(c(
    i = "Installing {.pkg {nm}} {.strong  v{ver}} in temporary library"
  ))
  withr::local_temp_libpaths(.local_envir = env)
  devtools::install(pkg,
    upgrade = "never",
    reload = FALSE, quick = TRUE, quiet = quiet
  )
}
