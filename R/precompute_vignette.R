#' Precompute vignettes
#'
#' @description
#' Precompute vignettes from CRAN, based on
#' <https://ropensci.org/blog/2019/12/08/precompute-vignettes/>.
#'
#' @param source Name without path of the `.Rmd.orig` file
#'   (e.g. `"some_name.Rmd.orig"`).
#' @param figure_ext Extension of the figures plotted on the vignette.
#'   See **Details**.
#'
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
                                figure_ext = ".png") {
  source <- file.path("vignettes", source)
  out <- gsub(".orig", "", source)
  usethis::use_build_ignore(source)


  knitr::knit(input = source, output = out)

  # Move plot files to dir

  plots <- list.files(".", pattern = figure_ext)
  plots_to_move <- file.path("vignettes", plots)

  res <- file.copy(plots, plots_to_move, overwrite = TRUE)

  rem <- file.remove(plots)

  # Create R file
  r_file <- gsub(".Rmd", ".R", out)
  knitr::purl(source, output = r_file)

  return(invisible())
}
