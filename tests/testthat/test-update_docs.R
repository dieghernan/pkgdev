test_that("env_var_is_true() reads logical environment values", {
  withr::local_envvar(
    PKGDEV_TEST_TRUE = "true",
    PKGDEV_TEST_FALSE = "false",
    PKGDEV_TEST_ONE = "1",
    PKGDEV_TEST_EMPTY = ""
  )

  expect_true(env_var_is_true("PKGDEV_TEST_TRUE"))
  expect_false(env_var_is_true("PKGDEV_TEST_FALSE"))
  expect_false(env_var_is_true("PKGDEV_TEST_ONE"))
  expect_false(env_var_is_true("PKGDEV_TEST_EMPTY"))
  expect_false(env_var_is_true("PKGDEV_TEST_MISSING"))
})

test_that("documentation settings preserve custom extensions", {
  pkg <- local_test_package()
  withr::local_dir(pkg)
  dir.create(".vscode")
  jsonlite::write_json(
    list(recommendations = c("custom.extension", "redhat.vscode-yaml")),
    ".vscode/extensions.json"
  )
  writeLines("existing configuration", "jarl.toml")

  update_docs_vscode(pkg, verbose = FALSE)

  settings <- jsonlite::read_json(".vscode/extensions.json")
  recommendations <- settings$recommendations
  expect_contains(unlist(recommendations), "custom.extension")
  expect_disjoint(unlist(recommendations), "redhat.vscode-yaml")
  expect_identical(readLines("jarl.toml"), "existing configuration")
})

test_that("documentation rebuilds dispatch Quarto inputs in order", {
  pkg <- local_test_package()
  dir.create(file.path(pkg, "pkgdown"))
  files <- file.path(pkg, c("README.qmd", "index.qmd", "pkgdown/index.qmd"))
  for (file in files) {
    writeLines("A document.", file)
  }
  state <- new.env(parent = emptyenv())
  state$files <- character()
  local_mocked_bindings(
    build_readme_qmd = function(path, quiet) {
      state$files <- c(state$files, file.path(path, "README.qmd"))
      expect_true(quiet)
    },
    build_qmd = function(file, path, quiet) {
      state$files <- c(state$files, file)
      expect_identical(path, pkg)
      expect_true(quiet)
    }
  )

  update_docs_readme(pkg, verbose = FALSE, build_readme = FALSE)
  expect_identical(state$files, character())
  update_docs_readme(pkg, verbose = FALSE, build_readme = TRUE)
  expect_identical(state$files, files)
})
