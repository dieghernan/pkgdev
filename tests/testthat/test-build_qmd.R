test_that("build_qmd() errors when a file does not exist", {
  pkg <- local_test_package()

  expect_snapshot(
    error = TRUE,
    build_qmd("missing.qmd", path = pkg)
  )
})

test_that("build_qmd() renders every input file", {
  pkg <- local_test_package()
  first <- file.path(pkg, "first.qmd")
  second <- file.path(pkg, "second.qmd")
  writeLines("---\ntitle: First\n---", first)
  writeLines("---\ntitle: Second\n---", second)

  installed <- list()
  rendered <- list()
  local_mocked_bindings(
    build_qmd_install = function(pkg, upgrade, reload, quick, quiet) {
      installed[[length(installed) + 1L]] <<- list(
        package = pkg$package,
        upgrade = upgrade,
        reload = reload,
        quick = quick,
        quiet = quiet
      )
    },
    build_qmd_package_version = function(...) {
      package_version("0.0.0.9000")
    },
    build_qmd_render = function(input, ..., quiet = TRUE) {
      rendered[[length(rendered) + 1L]] <<- list(input = input, quiet = quiet)
    }
  )

  expect_equal(build_qmd(c(first, second), path = pkg, quiet = FALSE), TRUE)

  expect_length(installed, 1)
  expect_equal(installed[[1]]$package, "testpkg")
  expect_equal(installed[[1]]$upgrade, FALSE)
  expect_equal(installed[[1]]$reload, FALSE)
  expect_equal(installed[[1]]$quick, TRUE)
  expect_equal(installed[[1]]$quiet, TRUE)
  expect_equal(lapply(rendered, `[[`, "input"), list(first, second))
  expect_equal(lapply(rendered, `[[`, "quiet"), list(FALSE, FALSE))
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
