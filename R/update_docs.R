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
#' * Optimize images with [resmush::resmush_dir()]
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
#' @param opt_imgs Logical. Optimize images with [resmush::resmush_dir()]?
#' @param opt_dir,opt_ext,opt_overwrite
#'   See `dir`, `ext` and `overwrite` in [resmush::resmush_dir()].
#' @param add_contributors Deprecated.
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
update_docs <- function(
  pkg = ".",
  url_update = TRUE,
  create_codemeta = TRUE,
  create_cff = TRUE,
  build_readme = TRUE,
  verbose = TRUE,
  precompute = TRUE,
  opt_imgs = TRUE,
  opt_dir = c(
    "man/figures",
    "vignettes"
  ),
  opt_ext = "png$|jpg$",
  opt_overwrite = TRUE,
  add_contributors = TRUE,
  ...
) {
  # Clean revdepcheck
  unlink(file.path(pkg, "revdep", "lib"), recursive = TRUE, force = TRUE)
  unlink(file.path(pkg, "revdep", "checks"), recursive = TRUE, force = TRUE)
  unlink(file.path(pkg, "revdep", "db"), recursive = TRUE, force = TRUE)
  unlink(file.path(pkg, "revdep", "lib"), recursive = TRUE, force = TRUE)

  # Add global .gitignore
  if (verbose) {
    cli::cli_alert_info("Adding {.file .gitignore} to root")
  }
  add_global_gitgnore(pkg = pkg)

  this <- list.files(".", pattern = "Rproj$")

  if (all(file.exists(this), length(this) > 0)) {
    if (verbose) {
      cli::cli_alert_info("Add project options to {.file {this}} file")
    }
    usethis::write_union(
      this,
      c(
        "MarkdownWrap: Column",
        "MarkdownWrapAtColumn: 80",
        "AutoAppendNewline: Yes",
        "StripTrailingWhitespace: Yes",
        "LineEndingConversion: Posix"
      )
    )
  }

  # Add Global options
  if (verbose) {
    cli::cli_alert_info("Setting RStudio Global Options")
  }

  usethis::use_rstudio_preferences(
    always_shown_files = TRUE,
    auto_append_newline = TRUE,
    auto_detect_indentation = TRUE,
    auto_discover_package_dependencies = TRUE,
    auto_expand_error_tracebacks = TRUE,
    clean_before_install = TRUE,
    cleanup_after_r_cmd_check = TRUE,
    code_formatter = "external",
    code_formatter_external_command = "air format",
    check_arguments_to_r_function_calls = TRUE,
    check_unexpected_assignment_in_function_call = TRUE,
    enable_splash_screen = FALSE,
    graphics_backend = "ragg",
    insert_native_pipe_operator = TRUE,
    insert_spaces_around_equals = TRUE,
    line_ending_conversion = "posix",
    margin_column = 80,
    margin_column_editor_width = FALSE,
    rainbow_parentheses = TRUE,
    reformat_on_save = TRUE,
    save_workspace = "never",
    show_doc_outline_rmd = TRUE,
    show_hidden_files = TRUE,
    strip_trailing_whitespace = TRUE,
    style_diagnostics = TRUE,
    syntax_color_console = TRUE,
    use_air_formatter = TRUE,
    use_roxygen = TRUE,
    visual_markdown_editing_is_default = TRUE,
    visual_markdown_editing_list_spacing = "tight",
    visual_markdown_editing_show_margin = TRUE,
    visual_markdown_editing_wrap = "column",
    visual_markdown_editing_wrap_at_column = 80L,
    warn_if_no_such_variable_in_scope = TRUE,
    warn_variable_defined_but_not_used = TRUE
  )

  if (verbose) {
    cli::cli_alert_info("Using {.fun usethis::use_blank_slate}")
  }
  usethis::use_blank_slate()

  if (!file.exists(".lintr")) {
    if (verbose) {
      cli::cli_alert_info("Add {.file .lintr} file")
    }
    lintr::use_lintr()

    # Ignore data-raw
    lnt <- readLines(".lintr")
    unlink(".lintr")
    newln <- c(lnt, 'exclusions: list("data-raw")')
    writeLines(newln, ".lintr")
  }

  if (verbose) {
    cli::cli_alert_info("Cleaning {.file DESCRIPTION}")
  }

  # Extract keywords and save it for later
  d <- desc::desc(file.path(pkg, "DESCRIPTION"))
  k <- d$get("X-schema.org-keywords")
  k <- gsub("\\n", "", unname(k))
  key <- trimws(unlist(strsplit(k, ",")))
  key <- key[!is.na(key)]
  if (length(key) > 0) {
    key <- unique(tolower(key))

    desc::desc_set_list(
      "X-schema.org-keywords",
      key,
      file = file.path(pkg, "DESCRIPTION")
    )
  }
  usethis::use_tidy_description()
  usethis::use_air()

  setting_json_file <- file.path(pkg, ".vscode", "settings.json")

  if (file.exists(setting_json_file)) {
    if (verbose) {
      cli::cli_alert_info("Configuring {.pkg VSCode} project settings.")
    }

    settings_json <- jsonlite::read_json(setting_json_file)

    settings_json <- modifyList(
      settings_json,
      list(
        `[github-actions-workflow]` = list(
          editor.defaultFormatter = "kennylong.kubernetes-yaml-formatter"
        ),
        `[yaml]` = list(
          editor.defaultFormatter = "kennylong.kubernetes-yaml-formatter"
        ),
        `better-yaml.directives` = FALSE,
        `better-yaml.flowCollectionPadding` = FALSE,
        `better-yaml.lineWidth` = 80,
        redhat.telemetry.enabled = NULL,
        yaml.completion = TRUE,
        yaml.format.printWidth = 80,
        yaml.validate = TRUE,
        files.eol = "\n"
      )
    )

    settings_json <- settings_json[sort(names(settings_json))]
    jsonlite::write_json(
      settings_json,
      path = setting_json_file,
      pretty = TRUE,
      auto_unbox = TRUE
    )
  }

  if (verbose) {
    cli::cli_alert_info("Configuring {.pkg VSCode} project extensions.")
  }

  ext_json_file <- file.path(pkg, ".vscode", "extensions.json")
  recommend_ext <- c(
    "Posit.air-vscode",
    "kennylong.kubernetes-yaml-formatter",
    "quarto.quarto",
    "github.vscode-github-actions",
    "GitHub.vscode-pull-request-github"
  )

  if (file.exists(ext_json_file)) {
    # Recommended
    already <- jsonlite::read_json(ext_json_file)
    recommend_ext <- unique(c(unlist(already$recommendations), recommend_ext))
    recommend_ext <- sort(recommend_ext[
      !grepl("redhat", recommend_ext, fixed = TRUE)
    ])
  }

  jsonlite::write_json(
    list(recommendations = recommend_ext),
    path = ext_json_file,
    pretty = TRUE,
    auto_unbox = TRUE
  )

  #   Use jarl config
  if (!file.exists("jarl.toml")) {
    if (verbose) {
      cli::cli_alert_info("Configuring {.pkg jarl}")
      cli::cli_alert("See more in {.url https://jarl.etiennebacher.com/}")
      cli::cli_alert(
        paste0(
          "Read {.href [jarl's docs ](https://jarl.etiennebacher.com/)} ",
          "to learn about jarl linter."
        )
      )
    }
    writeLines(
      "[lint]
ignore = [\"implicit_assignment\"]",
      "jarl.toml"
    )
  }

  if (url_update) {
    if (verbose) {
      cli::cli_alert_info("Checking URLs with {.pkg urlchecker}")
    }
    urlchecker::url_update(pkg)
  }

  if (verbose) {
    cli::cli_alert_info("Compressing data in {.path ./R}")
  }
  tools::resaveRdaFiles(file.path(pkg, "R"), compress = "auto")
  if (dir.exists(file.path(pkg, "data"))) {
    tools::resaveRdaFiles(file.path(pkg, "data"), compress = "auto")
  }

  if (Sys.which("git") != "") {
    system2("git", "config --global core.autocrlf true")
  }

  if (Sys.which("jarl") != "") {
    if (verbose) {
      cli::cli_alert_info("Linting package with {.pkg jarl}")
    }

    # Get R version from DESCRIPTION
    deps <- d$get_deps()
    if ("R" %in% deps$package) {
      rversion <- deps$version[deps$package == "R"]
      rversion <- trimws(gsub(">|=", "", rversion))
      jarl_args <- paste0("check . --min-r-version ", rversion)
    } else {
      jarl_args <- "check ."
    }

    system2("jarl", jarl_args)
  }
  if (Sys.which("air") != "") {
    if (verbose) {
      cli::cli_alert_info("Styling package with {.pkg air}")
    }
    system2("air", "format .")
  }

  if (verbose) {
    cli::cli_alert_info("Styling package with {.pkg styler}")
  }

  fmt_file_type <- c("r", "rmd", "rprofile", "qmd")

  styler::style_pkg(filetype = fmt_file_type)

  if (dir.exists(file.path(pkg, "vignettes"))) {
    styler::style_dir(
      file.path(pkg, "vignettes"),
      filetype = fmt_file_type
    )
  }

  if (dir.exists(file.path(pkg, "inst", "examples"))) {
    if (verbose) {
      cli::cli_alert_info(paste(
        "Styling external examples in",
        "{.path {file.path('inst', 'examples')}}"
      ))
    }
    styler::style_dir(
      file.path(pkg, "inst", "examples"),
      filetype = fmt_file_type
    )
  }

  if (dir.exists(file.path(pkg, "man", "roxygen2"))) {
    if (verbose) {
      cli::cli_alert_info(paste(
        "Styling meta roxygen2 in",
        "{.path {file.path('man', 'roxygen2')}}"
      ))
    }
    styler::style_dir(
      file.path(pkg, "man", "roxygen2"),
      filetype = fmt_file_type
    )
  }

  if (dir.exists(file.path(pkg, "man", "chunks"))) {
    if (verbose) {
      cli::cli_alert_info(paste(
        "Styling chunks in",
        "{.path {file.path('man', 'chunks')}}"
      ))
    }
    styler::style_dir(file.path(pkg, "man", "chunks"), filetype = fmt_file_type)
  }

  # Replace link-citations: yes for link-citations: true
  rmd <- list.files(
    pattern = "Rmd$|Rmd.orig$",
    recursive = TRUE,
    full.names = TRUE
  )

  if (length(rmd) > 0) {
    lapply(rmd, function(x) {
      lns <- readLines(x, warn = FALSE)
      lns <- gsub(
        "link-citations: yes",
        "link-citations: true",
        lns,
        fixed = TRUE
      )

      usethis::write_over(x, lns, quiet = FALSE, overwrite = TRUE)
      invisible()
    })
  }

  # Clean trailing spaces on yamls
  if (!env_var_is_true("CI")) {
    actions <- list.files(
      ".github",
      pattern = "yaml$|yml$",
      full.names = TRUE,
      recursive = TRUE
    )
  } else {
    actions <- NULL
  }
  others <- list.files(
    pattern = "yaml$|yml$",
    full.names = TRUE,
    recursive = TRUE
  )
  allyml <- c(actions, others)

  if (length(allyml) > 0) {
    lapply(allyml, function(x) {
      # This just removes trailing spaces and the install-r: true line
      lns <- readLines(x, warn = FALSE)
      lns <- gsub("install-r: true", "", lns, fixed = TRUE)

      usethis::write_over(x, lns, quiet = FALSE, overwrite = TRUE)
    })
  }

  if (verbose) {
    cli::cli_alert_info("Roxygenising package with {.pkg roxygen2}")
  }
  roxygen2::roxygenise()

  if (verbose) {
    cli::cli_alert_info("Checking {.var .Rd} titles")
  }

  rdtit <- check_rd_titles(pkg)

  if (!is.null(rdtit)) {
    enddot <- rdtit[rdtit$last == ".", ]

    if (nrow(enddot) != 0) {
      cli::cli_alert_warning("Found {.var Rd} files that ends with {.val .}")
      rds <- as.character(enddot$src)
      rds <- paste0("{.file ", rds, "}")
      names(rds) <- rep("*", length(rds))
      cli::cli_bullets(rds)
    }
  }

  if (verbose) {
    cli::cli_alert_info("Looking for {.val #'} in {.var .Rd} files")
  }

  rdhash <- check_rd_hash(pkg)

  if (!is.null(rdhash)) {
    has_hash <- rdhash[rdhash$bad_hash, ]

    if (nrow(has_hash) != 0) {
      cli::cli_alert_warning("Found {.val #'} in {.var Rd} files")
      rds <- as.character(has_hash$src)
      rds <- paste0("{.file ", rds, "}")
      names(rds) <- rep("*", length(rds))
      cli::cli_bullets(rds)
    }
  }

  if (precompute) {
    if (verbose) {
      cli::cli_alert_info("Precomputing vignettes")
    }
    precompute_vignette_all(pkg = pkg, ...)
  }
  # Check README.Rmd
  readme_rmd <- file.path(pkg, "README.Rmd")
  readme_qmd <- file.path(pkg, "README.qmd")
  has_readme <- file.exists(readme_rmd)
  has_readme_qmd <- file.exists(readme_qmd)
  has_any_readme <- any(has_readme, has_readme_qmd)

  if (build_readme && has_any_readme) {
    if (has_readme_qmd) {
      if (verbose) {
        cli::cli_alert_info("Rebuilding {.file {readme_qmd}}")
      }
      build_readme_qmd(pkg, quiet = isFALSE(verbose))
    } else {
      if (verbose) {
        cli::cli_alert_info("Rebuilding {.file {readme_rmd}}")
      }
      devtools::build_readme(pkg, quiet = isFALSE(verbose))
    }
  }

  if (opt_imgs) {
    try(
      resmush::resmush_dir(
        dir = opt_dir,
        ext = opt_ext,
        report = verbose,
        overwrite = opt_overwrite
      )
    )
    # Second pass, this affects if optipng is installed
    lapply(opt_dir, xfun::optipng)
    try(pkgdown::build_favicons(overwrite = TRUE))
  }

  if (create_cff) {
    if (verbose) {
      cli::cli_alert_info("Creating {.file CITATION.cff} with {.pkg cffr}")
    }

    cffr::cff_write(...)
    cffread <- cffr::cff_read(file.path(pkg, "CITATION.cff"))

    key <- unname(c(key, cffread$keywords))
  }

  # Finally add all the keywords (DESCRIPTION and cff)

  key <- trimws(key)
  key <- key[!is.na(key)]
  if (length(key) > 0) {
    key <- unique(tolower(key))

    desc::desc_set_list(
      "X-schema.org-keywords",
      key,
      file = file.path(pkg, "DESCRIPTION")
    )
  }

  usethis::use_tidy_description()

  if (dir.exists("inst")) {
    list_inst <- list.files("inst")
    if (length(list_inst) == 0) unlink("inst", recursive = TRUE)
  }

  if (create_codemeta) {
    if (verbose) {
      cli::cli_alert_info(
        "Creating {.file codemeta.json} with {.pkg codemetar}"
      )
    }
    codemetar::write_codemeta(write_minimeta = TRUE)
  }

  invisible()
}

env_var_is_true <- function(x) {
  isTRUE(as.logical(Sys.getenv(x, "false")))
}
