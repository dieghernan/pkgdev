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

  expect_true(build_qmd(c(first, second), path = pkg, quiet = FALSE))

  expect_length(installed, 1)
  expect_equal(installed[[1]]$package, "testpkg")
  expect_false(installed[[1]]$upgrade)
  expect_false(installed[[1]]$reload)
  expect_true(installed[[1]]$quick)
  expect_true(installed[[1]]$quiet)
  expect_equal(lapply(rendered, `[[`, "input"), list(first, second))
  expect_equal(lapply(rendered, `[[`, "quiet"), list(FALSE, FALSE))
})

test_that("build_qmd() honors quiet = TRUE", {
  pkg <- local_test_package()
  input <- file.path(pkg, "input.qmd")
  writeLines("---\ntitle: Input\n---", input)

  local_mocked_bindings(
    build_qmd_install = function(...) invisible(),
    build_qmd_package_version = function(...) package_version("0.0.0.9000"),
    build_qmd_render = function(...) invisible()
  )

  expect_silent(result <- build_qmd(input, path = pkg, quiet = TRUE))
  expect_true(result)
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

  expect_true(build_readme_qmd(path = ".", quiet = FALSE))
  expect_length(calls, 1)
  expect_equal(calls[[1]]$files, normalizePath(readme, winslash = "/"))
  expect_equal(calls[[1]]$path, ".")
  expect_false(calls[[1]]$quiet)
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

  expect_true(build_readme_qmd(path = "."))
  expect_length(calls, 1)
  expect_equal(calls[[1]]$files, normalizePath(readme, winslash = "/"))
  expect_equal(calls[[1]]$path, ".")
})
