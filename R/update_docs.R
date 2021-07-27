#' Document your package
#'
#' @description
#' Run routine checks on the package:
#' * Clean DESCRIPTION with [usethis::use_tidy_description()]
#' * Style code with [styler::style_pkg()]
#' * Check urls with [urlchecker::url_check()]
#' * Roxygenise with [roxygen2::roxygenise()]
#' * Rebuild `README.Rmd` (if present) with [devtools::build_readme()]
#' * Write codemeta with [codemetar::write_codemeta()]
#'
#' @param url_update Logical, do you want to update urls with
#'  [urlchecker::url_update()] or just check?
#' @param build_readme Logical, build `README.Rmd` with
#'   [devtools::build_readme()]
#' @param verbose Display informative messages on the console
#'
#' @inheritParams styler::style_pkg
#'
#' @return invisible, or some messages on `verbose = TRUE`.
#'
#' @details
#' This function tries to update and clean the package following a mix of
#' best practices (e.g. checking the urls, roxygenise and rebuilding the
#' `README`) and some other discretionary practices I like to have in a package,
#' as the `tidyverse` approach for the `DESCRIPTION` file and overall code
#' and the use of `codemeta.json`.
#'
#' @examples
#' \dontrun{
#'
#' update_docs()
#' }
#'
#' @seealso [usethis::use_tidy_description()], [styler::style_pkg()],
#'   [urlchecker::url_check()], [roxygen2::roxygenise()],
#'   [devtools::build_readme()], [codemetar::write_codemeta()]
#'
#' @export
#'
#'

update_docs <- function(pkg = ".",
                        url_update = TRUE,
                        build_readme = TRUE,
                        verbose = TRUE) {

  # Add global .gitignore




  if (verbose) message("Add .gitignore to root")
  add_global_gitgnore(pkg = pkg)



  if (verbose) message("Cleaning description")
  usethis::use_tidy_description()

  if (verbose) message("Styling package")
  styler::style_pkg(filetype = c(c("R", "Rmd", "Rprofile")))

  if (verbose) message("Url check")
  if (url_update) {
    if (verbose) message("Update")
    urlchecker::url_update(pkg)
  } else {
    if (verbose) message("Check")
    urlchecker::url_check(pkg)
  }

  if (verbose) message("Roxygen")
  roxygen2::roxygenise()

  # Check README.Rmd
  readme_rmd <- file.path(pkg, "README.Rmd")
  has_readme <- file.exists(readme_rmd)

  if (build_readme && has_readme) {
    if (verbose) message("Rebuild README.Rmd")
    devtools::build_readme(pkg, quiet = isFALSE(verbose))
  }


  if (verbose) message("Codemeta")
  if (!dir.exists(file.path(pkg, "inst"))) {
    if (verbose) message("Create /inst folder")
    dir.create(file.path(pkg, "inst"), recursive = TRUE)
  }

  if (verbose) message("Creating codemetar")
  codemetar::write_codemeta(write_minimeta = TRUE)

  return(invisible())
}
