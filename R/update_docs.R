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
#' * Write codemeta.json with [codemetar::write_codemeta()]
#' * Write CITATION.cff with [cffr::cff_write()]
#'
#' @param url_update Logical, do you want to update urls with
#'  [urlchecker::url_update()]?
#' @param build_readme Logical, build `README.Rmd` with
#'   [devtools::build_readme()]
#' @param create_codemeta Logical, do you want to create
#'   a codemeta file with [codemetar::write_codemeta()]?
#' @param create_cff Logical, do you want to create
#'   a CITATION.cff file with [cffr::cff_write()]?
#' @param verbose Display informative messages on the console
#' @param precompute Logical, detect and precompute vignettes? See also
#'   [precompute_vignette()].
#'
#' @param ... Additional arguments to functions
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
#'   [devtools::build_readme()], [codemetar::write_codemeta()],
#'   [tools::resaveRdaFiles()]
#'
#' @export
#'
#'
update_docs <- function(pkg = ".",
                        url_update = TRUE,
                        create_codemeta = TRUE,
                        create_cff = TRUE,
                        build_readme = TRUE,
                        verbose = TRUE,
                        precompute = TRUE,
                        ...) {
  # Add global .gitignore
  if (verbose) cli::cli_alert_info("Adding {.file .gitignore} to root")
  add_global_gitgnore(pkg = pkg)


  this <- list.files(".", pattern = "Rproj$")

  if (all(file.exists(this), length(this) > 0)) {
    if (verbose) {
      cli::cli_alert_info("Add project options to {.file {this}} file")
    }
    usethis::write_union(this, c(
      "MarkdownWrap: Column",
      "MarkdownWrapAtColumn: 80",
      "AutoAppendNewline: Yes",
      "StripTrailingWhitespace: Yes",
      "LineEndingConversion: Posix"
    ))
  }

  # Add Global options
  if (verbose) {
    cli::cli_alert_info("Setting RStudio Global Options")
  }

  usethis::use_rstudio_preferences(
    graphics_backend = "ragg",
    rainbow_parentheses = TRUE,
    visual_markdown_editing_wrap_at_column = 80L,
    visual_markdown_editing_wrap = "column",
    check_arguments_to_r_function_calls = TRUE,
    check_unexpected_assignment_in_function_call = TRUE,
    warn_if_no_such_variable_in_scope = TRUE,
    warn_variable_defined_but_not_used = TRUE,
    style_diagnostics = TRUE
  )

  if (verbose) cli::cli_alert_info("Using {.fun usethis::use_blank_slate}")
  usethis::use_blank_slate()


  if (!file.exists(".lintr")) {
    if (verbose) cli::cli_alert_info("Add {.file .lintr} file")
    lintr::use_lintr()

    # Ignore data-raw
    lnt <- readLines(".lintr")
    unlink(".lintr")
    newln <- c(lnt, 'exclusions: list("data-raw")')
    writeLines(newln, ".lintr")
  }


  if (verbose) cli::cli_alert_info("Cleaning {.file DESCRIPTION}")
  usethis::use_tidy_description()

  if (url_update) {
    if (verbose) cli::cli_alert_info("Checking URLs with {.pkg urlchecker}")
    urlchecker::url_update(pkg)
  }

  if (verbose) cli::cli_alert_info("Compressing data in {.path ./R}")
  tools::resaveRdaFiles(file.path(pkg, "R"), compress = "auto")
  if (dir.exists(file.path(pkg, "data"))) {
    tools::resaveRdaFiles(file.path(pkg, "data"), compress = "auto")
  }
  if (verbose) cli::cli_alert_info("Styling package with {.pkg styler}")
  styler::style_pkg(filetype = c("R", "Rmd", "Rprofile"))

  if (dir.exists(file.path(pkg, "vignettes"))) {
    styler::style_dir(file.path(pkg, "vignettes"), filetype = c(
      "R", "Rmd",
      "Rprofile"
    ))
  }

  if (dir.exists(file.path(pkg, "inst", "examples"))) {
    if (verbose) {
      cli::cli_alert_info(paste(
        "Styling external examples in",
        "{.path {file.path('inst', 'examples')}}"
      ))
    }
    styler::style_dir(file.path(pkg, "inst", "examples"))
  }


  # Clean trailing spaces on yamls

  actions <- list.files(".github",
    pattern = "yaml$|yml$", full.names = TRUE,
    recursive = TRUE
  )
  others <- list.files(
    pattern = "yaml$|yml$", full.names = TRUE,
    recursive = TRUE
  )
  allyml <- c(actions, others)

  if (length(allyml) > 0) {
    lapply(allyml, function(x) {
      lns <- readLines(x, warn = FALSE)
      newlns <- trimws(lns, which = "right")

      # Add EOL
      if (identical(newlns[length(newlns)], "")) newlns <- c(newlns, "")
      usethis::write_over(x, newlns, quiet = FALSE, overwrite = TRUE)
    })
  }

  if (verbose) cli::cli_alert_info("Roxygenising package with {.pkg roxygen2}")
  roxygen2::roxygenise()


  if (precompute) {
    if (verbose) cli::cli_alert_info("Precomputing vignettes")
    precompute_vignette_all(...)
  }
  # Check README.Rmd
  readme_rmd <- file.path(pkg, "README.Rmd")
  has_readme <- file.exists(readme_rmd)

  if (build_readme && has_readme) {
    if (verbose) cli::cli_alert_info("Rebuilding {.file {readme_rmd}}")
    devtools::build_readme(pkg, quiet = isFALSE(verbose))
  }

  if (create_codemeta) {
    if (verbose) {
      cli::cli_alert_info(
        "Creating {.file codemeta.json} with {.pkg codemetar}"
      )
    }
    codemetar::write_codemeta(write_minimeta = TRUE)
  }
  if (create_cff) {
    if (verbose) {
      cli::cli_alert_info("Creating {.file CITATION.cff} with {.pkg cffr}")
    }

    cffr::cff_write(...)
  }


  if (dir.exists("inst")) {
    list_inst <- list.files("inst")
    if (length(list_inst) == 0) unlink("inst", recursive = TRUE)
  }

  return(invisible())
}
