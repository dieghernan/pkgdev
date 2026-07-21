#' Document your package
#'
#' @description
#' Run routine checks on the package:
#' - Clean `DESCRIPTION` with [usethis::use_tidy_description()].
#' - Compress data in the `"./data"` and `"./R"` paths using
#'   [tools::resaveRdaFiles()].
#' - Style code with [styler::style_pkg()].
#' - Check URLs with [urlchecker::url_check()].
#' - Roxygenize with [roxygen2::roxygenise()].
#' - Precompute vignettes, if present
#'   (see <https://ropensci.org/blog/2019/12/08/precompute-vignettes/>).
#' - Rebuild `README.qmd`, `README.Rmd` or pkgdown index files, if present.
#' - Optimize images with [resmush::resmush_dir()].
#' - Write `codemeta.json` with [codemetar::write_codemeta()].
#' - Write `CITATION.cff` with [cffr::cff_write()].
#' - Write a project-level Codex configuration file.
#'
#' @details
#' This function updates and cleans the package using a mix of best practices,
#' such as checking URLs, roxygenizing and rebuilding the `README`. It also
#' applies discretionary practices such as the tidyverse approach for the
#' `DESCRIPTION` file, overall code style and `codemeta.json`.
#'
#' @param url_update A logical value. Should URLs be updated with
#'   [urlchecker::url_update()]?
#' @param build_readme A logical value. Should `README.qmd`, `README.Rmd` or
#'   pkgdown index files be built?
#' @param create_codemeta A logical value. Should `codemeta.json` be created
#'   with [codemetar::write_codemeta()]?
#' @param create_cff A logical value. Should `CITATION.cff` be created with
#'   [cffr::cff_write()]?
#' @param verbose A logical value. Should informative messages be displayed on
#'   the console?
#' @param precompute A logical value. Should vignettes be detected and
#'   precomputed? See also [precompute_vignette()].
#' @param opt_imgs A logical value. Should images be optimized with
#'   [resmush::resmush_dir()]?
#' @param opt_dir,opt_ext,opt_overwrite Options passed to the `dir`, `ext` and
#'   `overwrite` arguments of [resmush::resmush_dir()].
#' @param add_contributors Deprecated.
#' @param ... Additional arguments passed to downstream functions.
#' @inheritParams styler::style_pkg
#'
#' @return Invisibly returns `NULL`. When `verbose = TRUE`, it emits progress
#'   messages.
#'
#' @seealso
#' - [add_global_gitgnore()] updates package ignore files.
#' - [build_qmd()] builds Quarto files.
#' - [check_rd_titles()] checks generated Rd titles.
#' - [precompute_vignette()] precomputes vignettes.
#' - [usethis::use_tidy_description()] cleans `DESCRIPTION`.
#' - [styler::style_pkg()] styles package code.
#' - [urlchecker::url_check()] checks URLs.
#' - [roxygen2::roxygenise()] updates documentation.
#' - [devtools::build_readme()] builds `README.Rmd` files.
#' - [codemetar::write_codemeta()] writes `codemeta.json`.
#' - [tools::resaveRdaFiles()] compresses data files.
#'
#' @family maintenance
#'
#' @export
#' @encoding UTF-8
#'
#' @examples
#' \dontrun{
#' update_docs()
#' }
# nocov start
update_docs <- function(
  pkg = ".",
  url_update = TRUE,
  create_codemeta = TRUE,
  create_cff = TRUE,
  build_readme = TRUE,
  verbose = TRUE,
  precompute = TRUE,
  opt_imgs = TRUE,
  opt_dir = c("man/figures", "vignettes"),
  opt_ext = "png$|jpg$",
  opt_overwrite = TRUE,
  add_contributors = TRUE,
  ...
) {
  usethis::proj_set(pkg)
  # Clean revdepcheck.
  unlink(file.path(pkg, "revdep", "checks"), recursive = TRUE, force = TRUE)
  unlink(file.path(pkg, "revdep", "library"), recursive = TRUE, force = TRUE)
  unlink(
    file.path(pkg, "revdep", "checks.noindex"),
    recursive = TRUE,
    force = TRUE
  )
  unlink(
    file.path(pkg, "revdep", "library.noindex"),
    recursive = TRUE,
    force = TRUE
  )
  unlink(
    file.path(pkg, "revdep", "data.sqlite"),
    recursive = TRUE,
    force = TRUE
  )

  # Add global `.gitignore`.
  if (verbose) {
    cli::cli_alert_info("Updating root {.file .gitignore}.")
  }
  add_global_gitgnore(pkg = pkg)

  this <- list.files(".", pattern = "Rproj$")

  if (all(file.exists(this), length(this) > 0)) {
    if (verbose) {
      cli::cli_alert_info("Updating project options in {.file {this}}.")
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

  # Add global options.
  if (verbose) {
    cli::cli_alert_info("Updating RStudio global options.")
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
    indent_guides = "gray",
    insert_native_pipe_operator = TRUE,
    insert_spaces_around_equals = TRUE,
    highlight_r_function_calls = TRUE,
    line_ending_conversion = "posix",
    margin_column = 80,
    margin_column_editor_width = FALSE,
    rainbow_parentheses = FALSE,
    reformat_on_save = TRUE,
    save_workspace = "never",
    show_doc_outline_rmd = TRUE,
    show_hidden_files = TRUE,
    strip_trailing_whitespace = TRUE,
    style_diagnostics = TRUE,
    syntax_color_console = TRUE,
    use_air_formatter = TRUE,
    use_roxygen = TRUE,
    visual_markdown_editing_canonical = TRUE,
    visual_markdown_editing_is_default = TRUE,
    visual_markdown_editing_list_spacing = "tight",
    visual_markdown_editing_show_margin = TRUE,
    visual_markdown_editing_wrap = "column",
    visual_markdown_editing_wrap_at_column = 80L,
    warn_if_no_such_variable_in_scope = TRUE,
    warn_variable_defined_but_not_used = TRUE
  )

  if (verbose) {
    cli::cli_alert_info("Running {.fn usethis::use_blank_slate}.")
  }
  usethis::use_blank_slate()

  if (!file.exists(".lintr")) {
    if (verbose) {
      cli::cli_alert_info("Creating {.file .lintr}.")
    }
    lintr::use_lintr()

    # Ignore `data-raw`.
    lnt <- readLines(".lintr")
    unlink(".lintr")
    newln <- c(lnt, 'exclusions: list("data-raw")')
    writeLines(newln, ".lintr")
  }

  if (verbose) {
    cli::cli_alert_info("Cleaning {.file DESCRIPTION}.")
  }

  # Extract keywords and save them for later.
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

  # Migrate to Roxygen > v8.
  dsc_f <- file.path(pkg, "DESCRIPTION")
  dsc_lines <- readLines(dsc_f)

  dsc_lines[dsc_lines == "Config/roxygen2/version: 8.0.0.9000"] <- paste0(
    "Config/roxygen2/version: ",
    "8.0.0"
  )
  dsc_lines <- dsc_lines[!grepl("Roxygen: list", dsc_lines)]
  dsc_lines <- unique(c(dsc_lines, "Config/roxygen2/markdown: TRUE"))

  usethis::write_over(dsc_f, dsc_lines, overwrite = TRUE)

  usethis::use_tidy_description()
  usethis::use_air()

  setting_json_file <- file.path(pkg, ".vscode", "settings.json")

  if (file.exists(setting_json_file)) {
    if (verbose) {
      cli::cli_alert_info("Configuring VS Code project settings.")
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
    cli::cli_alert_info("Configuring VS Code project extensions.")
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
    # Keep existing recommendations.
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

  # Use `jarl` config.
  if (!file.exists("jarl.toml")) {
    if (verbose) {
      cli::cli_alert_info("Configuring {.pkg jarl}.")
      cli::cli_inform(c(
        "i" = "See {.url https://jarl.etiennebacher.com/}.",
        "i" = paste0(
          "Read {.href [jarl docs](https://jarl.etiennebacher.com/)} ",
          "to learn about the {.pkg jarl} linter."
        )
      ))
    }
    writeLines(
      "[lint]
ignore = [\"implicit_assignment\"]",
      "jarl.toml"
    )
  }

  if (url_update) {
    if (verbose) {
      cli::cli_alert_info("Checking URLs with {.pkg urlchecker}.")
    }
    urlchecker::url_update(pkg)
  }

  if (verbose) {
    cli::cli_alert_info("Compressing data in {.path ./R}.")
  }
  tools::resaveRdaFiles(file.path(pkg, "R"), compress = "auto")
  if (dir.exists(file.path(pkg, "data"))) {
    tools::resaveRdaFiles(file.path(pkg, "data"), compress = "auto")
  }

  if (Sys.which("git") != "") {
    system2("git", "config --global core.autocrlf true")
  }

  if (verbose) {
    cli::cli_alert_info("Configuring {.pkg Codex}.")
  }

  codex_dir <- file.path(pkg, ".codex")
  codex_config <- file.path(codex_dir, "config.toml")

  if (!dir.exists(codex_dir)) {
    dir.create(codex_dir, recursive = TRUE)
  }

  usethis::write_over(
    codex_config,
    c(
      'approval_policy = "never"',
      'sandbox_mode = "danger-full-access"',
      'personality = "pragmatic"'
    ),
    overwrite = TRUE
  )

  if (Sys.which("jarl") != "") {
    if (verbose) {
      cli::cli_alert_info("Linting package with {.pkg jarl}.")
    }

    # Get R version from `DESCRIPTION`.
    deps <- d$get_deps()
    if ("R" %in% deps$package) {
      rversion <- deps$version[deps$package == "R"]
      rversion <- trimws(gsub(">|=", "", rversion))
      jarl_args <- paste0(
        "check . --fix --allow-dirty --unsafe-fixes --min-r-version ",
        rversion
      )
    } else {
      jarl_args <- "check . --fix --allow-dirty --unsafe-fixes"
    }

    system2("jarl", jarl_args)
  }
  if (Sys.which("air") != "") {
    if (verbose) {
      cli::cli_alert_info("Styling package with {.pkg air}.")
    }
    system2("air", "format .")
  }

  # Replace `link-citations: yes` with `link-citations: true`.
  rmd <- list.files(
    pattern = "Rmd$|Rmd.orig$",
    recursive = TRUE,
    full.names = TRUE
  )

  if (length(rmd) > 0) {
    if (verbose) {
      cli::cli_alert_info("Adapting {.file .Rmd} files to {.pkg Quarto}.")
    }

    lapply(rmd, function(x) {
      lns <- readLines(x, warn = FALSE)
      lns <- gsub(
        "link-citations: yes",
        "link-citations: true",
        lns,
        fixed = TRUE
      )

      usethis::write_over(x, lns, quiet = FALSE, overwrite = TRUE)
      knitr::convert_chunk_header(x, x, type = "yaml")
      invisible()
    })
  }

  qmd <- list.files(
    pattern = "qmd$|qmd.orig$",
    recursive = TRUE,
    full.names = TRUE
  )

  if (length(qmd) > 0) {
    if (verbose) {
      cli::cli_alert_info("Adapting {.file .qmd} files to {.pkg Quarto}.")
    }

    lapply(qmd, function(x) {
      lns <- readLines(x, warn = FALSE)
      lns <- gsub(
        "link-citations: yes",
        "link-citations: true",
        lns,
        fixed = TRUE
      )

      usethis::write_over(x, lns, quiet = FALSE, overwrite = TRUE)
      knitr::convert_chunk_header(x, x, type = "yaml")
      invisible()
    })
  }

  if (verbose) {
    cli::cli_alert_info("Styling package with {.pkg styler}.")
  }

  fmt_file_type <- c("r", "rmd", "rprofile", "qmd")

  styler::style_pkg(filetype = fmt_file_type)

  if (dir.exists(file.path(pkg, "vignettes"))) {
    styler::style_dir(file.path(pkg, "vignettes"), filetype = fmt_file_type)
  }

  if (dir.exists(file.path(pkg, "inst", "examples"))) {
    if (verbose) {
      cli::cli_alert_info(
        "Styling external examples in {.path {file.path('inst', 'examples')}}."
      )
    }
    styler::style_dir(
      file.path(pkg, "inst", "examples"),
      filetype = fmt_file_type
    )
  }

  if (dir.exists(file.path(pkg, "man", "roxygen2"))) {
    if (verbose) {
      cli::cli_alert_info(
        "Styling meta roxygen2 in {.path {file.path('man', 'roxygen2')}}."
      )
    }
    styler::style_dir(
      file.path(pkg, "man", "roxygen2"),
      filetype = fmt_file_type
    )
  }

  if (dir.exists(file.path(pkg, "man", "chunks"))) {
    if (verbose) {
      cli::cli_alert_info(
        "Styling chunks in {.path {file.path('man', 'chunks')}}."
      )
    }
    styler::style_dir(file.path(pkg, "man", "chunks"), filetype = fmt_file_type)
  }

  # Clean trailing spaces in YAML files.
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
      # Remove trailing spaces and the `install-r: true` line.
      lns <- readLines(x, warn = FALSE)
      lns <- gsub("install-r: true", "", lns, fixed = TRUE)

      usethis::write_over(x, lns, quiet = FALSE, overwrite = TRUE)
    })
  }

  if (verbose) {
    cli::cli_alert_info("Roxygenizing package with {.pkg roxygen2}.")
  }
  roxygen2::roxygenise()

  if (verbose) {
    cli::cli_alert_info("Checking {.file .Rd} titles.")
  }

  rdtit <- check_rd_titles(pkg)

  if (!is.null(rdtit)) {
    enddot <- rdtit[rdtit$last == ".", ]

    if (nrow(enddot) != 0) {
      cli::cli_alert_warning(
        "Found {.file .Rd} files with titles that end in {.val .}."
      )
      rds <- as.character(enddot$src)
      rds <- paste0("{.file ", rds, "}")
      names(rds) <- rep("*", length(rds))
      cli::cli_bullets(rds)
    }
  }

  if (verbose) {
    cli::cli_alert_info("Looking for {.code #'} in {.file .Rd} files.")
  }

  rdhash <- check_rd_hash(pkg)

  if (!is.null(rdhash)) {
    has_hash <- rdhash[rdhash$bad_hash, ]

    if (nrow(has_hash) != 0) {
      cli::cli_alert_warning(
        "Found leaked roxygen markers in {.file .Rd} files."
      )
      rds <- as.character(has_hash$src)
      rds <- paste0("{.file ", rds, "}")
      names(rds) <- rep("*", length(rds))
      cli::cli_bullets(rds)
    }
  }

  if (verbose) {
    cli::cli_alert_info("Checking missing fields in {.file .Rd} files.")
  }
  devtools::check_doc_fields(pkg, fields = c("value", "examples", "encoding"))

  if (verbose) {
    cli::cli_alert_info("Running {.pkg codetools}.")
  }

  desc_obj <- desc::desc(pkg)
  pkname <- desc_obj$get("Package")
  codetools::checkUsagePackage(pkname)

  if (precompute) {
    if (verbose) {
      cli::cli_alert_info("Precomputing vignettes.")
    }
    precompute_vignette_all(pkg = pkg, ...)
  }
  # Check `README.Rmd`.
  readme_rmd <- file.path(pkg, "README.Rmd")
  index_rmd <- file.path(pkg, "index.Rmd")
  index2_rmd <- file.path(pkg, "pkgdown/index.Rmd")

  readme_qmd <- file.path(pkg, "README.qmd")
  index_qmd <- file.path(pkg, "index.qmd")
  index2_qmd <- file.path(pkg, "pkgdown/index.qmd")

  has_readme <- file.exists(readme_rmd)
  has_readme_qmd <- file.exists(readme_qmd)
  has_index <- file.exists(index_rmd)
  has_index_qmd <- file.exists(index_qmd)
  has_index2 <- file.exists(index2_rmd)
  has_index2_qmd <- file.exists(index2_qmd)

  has_any_readme <- any(
    has_readme,
    has_readme_qmd,
    has_index,
    has_index2,
    has_index_qmd,
    has_index2_qmd
  )

  if (build_readme && has_any_readme) {
    if (has_readme_qmd) {
      if (verbose) {
        cli::cli_alert_info("Rebuilding {.file {readme_qmd}}")
      }
      build_readme_qmd(pkg, quiet = isFALSE(verbose))
    }

    if (has_index) {
      if (verbose) {
        cli::cli_alert_info("Rebuilding {.file {index_rmd}}")
      }
      devtools::build_rmd(index_rmd, pkg, quiet = isFALSE(verbose))
    }

    if (has_index2) {
      if (verbose) {
        cli::cli_alert_info("Rebuilding {.file {index2_rmd}}")
      }
      devtools::build_rmd(index2_rmd, pkg, quiet = isFALSE(verbose))
    }

    if (has_index_qmd) {
      if (verbose) {
        cli::cli_alert_info("Rebuilding {.file {index_qmd}}")
      }

      build_qmd(index_qmd, pkg, quiet = isFALSE(verbose))
    }

    if (has_index2_qmd) {
      if (verbose) {
        cli::cli_alert_info("Rebuilding {.file {index2_qmd}}")
      }

      build_qmd(index2_qmd, pkg, quiet = isFALSE(verbose))
    }

    if (has_readme) {
      if (verbose) {
        cli::cli_alert_info("Rebuilding {.file {readme_rmd}}")
      }
      devtools::build_readme(pkg, quiet = isFALSE(verbose))
    }
  }

  if (opt_imgs) {
    try(resmush::resmush_dir(
      dir = opt_dir,
      ext = opt_ext,
      report = verbose,
      overwrite = opt_overwrite
    ))
    # Run a second pass when `optipng` is installed.
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

  # Finally, add all keywords from `DESCRIPTION` and `CITATION.cff`.

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
# nocov end

env_var_is_true <- function(x) {
  isTRUE(as.logical(Sys.getenv(x, "false")))
}
