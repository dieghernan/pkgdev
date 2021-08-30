#' Document your package
#'
#' @description
#' Run routine checks on the package:
#' * Clean DESCRIPTION with [usethis::use_tidy_description()]
#' * Compress the data of the paths `"./data"` and `"./R"` using
#'   [tools::resaveRdaFiles()].
#' * Style code with [styler::style_pkg()]
#' * Check urls with [urlchecker::url_check()]
#' * Roxygenise with [roxygen2::roxygenise()]
#' * Precompute vignettes if present
#'   (see <https://ropensci.org/blog/2019/12/08/precompute-vignettes/>)
#' * Rebuild `README.Rmd` (if present) with [devtools::build_readme()]
#' * Write codemeta with [codemeta::write_codemeta()]
#'
#' @param url_update Logical, do you want to update urls with
#'  [urlchecker::url_update()]?
#' @param build_readme Logical, build `README.Rmd` with
#'   [devtools::build_readme()]
#' @param create_codemeta Logical, do you want to create
#'   a codemeta file with [codemeta::write_codemeta()]?
#' @param verbose Display informative messages on the console
#' @param precompute Logical, detect and precompute vignettes? See also
#'   [precompute_vignette()].
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
#'   [devtools::build_readme()], [codemeta::write_codemeta()],
#'   [tools::resaveRdaFiles()]
#'
#' @export
#'
#'

update_docs <- function(pkg = ".",
                        url_update = TRUE,
                        create_codemeta = TRUE,
                        build_readme = TRUE,
                        verbose = TRUE,
                        precompute = TRUE) {

  # Add global .gitignore




  if (verbose) cat(crayon::green("Add .gitignore to root\n"))
  add_global_gitgnore(pkg = pkg)



  if (verbose) cat(crayon::green("Cleaning DESCRIPTION\n"))
  usethis::use_tidy_description()

  if (verbose) cat(crayon::green("Compressing data\n"))
  tools::resaveRdaFiles(file.path(pkg, "R"), compress = "auto")
  if (dir.exists(file.path(pkg, "data"))) {
    tools::resaveRdaFiles(file.path(pkg, "data"), compress = "auto")
  }
  if (verbose) cat(crayon::green("styler package\n"))
  styler::style_pkg(filetype = c("R", "Rmd", "Rprofile"))

  if (dir.exists(file.path(pkg, "vignettes"))) {
    styler::style_dir(file.path(pkg, "vignettes"), filetype = c("R", "Rmd", "Rprofile"))
  }

  if (dir.exists(file.path(pkg, "inst", "examples"))) {
    if (verbose) cat(crayon::green("styler external examples\n"))
    styler::style_dir(file.path(pkg, "inst", "examples"))
  }

  if (url_update) {
    if (verbose) cat(crayon::green("Check URLs\n"))
    urlchecker::url_update(pkg)
  }

  if (verbose) cat(crayon::green("Roxygenising package\n"))
  roxygen2::roxygenise()


  if (precompute) {
    vignette_list <- list.files(file.path(pkg, "vignettes"))
    find_vignettes <- grep(".Rmd.orig$", vignette_list)
    if (length(find_vignettes) > 0) {
      if (verbose) cat(crayon::green("Precomputing vignettes\n"))

      vig <- vignette_list[find_vignettes]
      for (i in seq_len(length(find_vignettes))) {
        precompute_vignette(source = vig[i])
      }
    } else {
      if (verbose) cat(crayon::green("No vignettes for precomputing found\n"))
    }
  }
  # Check README.Rmd
  readme_rmd <- file.path(pkg, "README.Rmd")
  has_readme <- file.exists(readme_rmd)

  if (build_readme && has_readme) {
    if (verbose) cat(crayon::green("Rebuilding README\n"))
    devtools::build_readme(pkg, quiet = isFALSE(verbose))
  }

  if (create_codemeta) {
    if (verbose) cat(crayon::green("Creating codemeta\n"))

    codemeta::write_codemeta()
  }

  # Cleanup previous pkgdev versions

  if (file.exists(file.path("inst", "schemaorg.json"))) {
    file.remove(file.path("inst", "schemaorg.json"))
  }

  if (dir.exists("inst")) {
    list_inst <- list.files("inst")
    if (length(list_inst) == 0) unlink("inst", recursive = TRUE)
  }

  return(invisible())
}
