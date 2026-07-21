test_that("build_qmd() errors when a file does not exist", {
  pkg <- local_test_package()

  expect_snapshot(
    error = TRUE,
    build_qmd("missing.qmd", path = pkg)
  )
})

test_that("build_readme_qmd() errors when README.qmd is missing", {
  pkg <- local_test_package()

  expect_snapshot(
    error = TRUE,
    build_readme_qmd(path = pkg)
  )
})

test_that("build_readme_qmd() errors when root and inst README.qmd exist", {
  pkg <- local_test_package()
  dir.create(file.path(pkg, "inst"))
  writeLines("---\ntitle: Root\n---", file.path(pkg, "README.qmd"))
  writeLines("---\ntitle: Inst\n---", file.path(pkg, "inst", "README.qmd"))

  expect_snapshot(
    error = TRUE,
    build_readme_qmd(path = pkg)
  )
})

test_that("build_readme_qmd() builds a root README.qmd", {
  pkg <- local_test_project()
  readme <- file.path(pkg, "README.qmd")
  writeLines("---\ntitle: Root\n---", readme)

  calls <- list()
  local_mocked_bindings(
    build_qmd = function(files, path, ..., quiet = TRUE) {
      calls[[length(calls) + 1L]] <<- list(
        files = files,
        path = path,
        quiet = quiet
      )
      invisible(TRUE)
    }
  )

  expect_equal(build_readme_qmd(path = ".", quiet = FALSE), TRUE)
  expect_length(calls, 1)
  expect_equal(calls[[1]]$files, normalizePath(readme, winslash = "/"))
  expect_equal(calls[[1]]$path, ".")
  expect_equal(calls[[1]]$quiet, FALSE)
})

test_that("build_readme_qmd() builds an inst README.qmd", {
  pkg <- local_test_project()
  dir.create(file.path(pkg, "inst"))
  readme <- file.path(pkg, "inst", "README.qmd")
  writeLines("---\ntitle: Inst\n---", readme)

  calls <- list()
  local_mocked_bindings(
    build_qmd = function(files, path, ..., quiet = TRUE) {
      calls[[length(calls) + 1L]] <<- list(files = files, path = path)
      invisible(TRUE)
    }
  )

  expect_equal(build_readme_qmd(path = "."), TRUE)
  expect_length(calls, 1)
  expect_equal(calls[[1]]$files, normalizePath(readme, winslash = "/"))
  expect_equal(calls[[1]]$path, ".")
})
