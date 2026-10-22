test_that("build_qmd() errors when a file does not exist", {
  pkg <- local_test_package()

  expect_snapshot(
    error = TRUE,
    build_qmd("missing.qmd", path = pkg)
  )
})

test_that("build_qmd() renders every input file", {
  state <- new.env(parent = emptyenv())
  pkg <- local_test_package()
  first <- file.path(pkg, "first.qmd")
  second <- file.path(pkg, "second.qmd")
  writeLines("---\ntitle: First\n---", first)
  writeLines("---\ntitle: Second\n---", second)

  state$installed <- list()
  state$rendered <- list()
  local_mocked_bindings(
    build_qmd_install = function(pkg, upgrade, reload, quick, quiet) {
      state$installed[[length(state$installed) + 1L]] <- list(
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
      state$rendered[[length(state$rendered) + 1L]] <- list(
        input = input,
        quiet = quiet
      )
    }
  )

  expect_true(build_qmd(c(first, second), path = pkg, quiet = FALSE))

  expect_length(state$installed, 1)
  expect_equal(state$installed[[1]]$package, "testpkg")
  expect_false(state$installed[[1]]$upgrade)
  expect_false(state$installed[[1]]$reload)
  expect_true(state$installed[[1]]$quick)
  expect_true(state$installed[[1]]$quiet)
  expect_equal(lapply(state$rendered, `[[`, "input"), list(first, second))
  expect_equal(lapply(state$rendered, `[[`, "quiet"), list(FALSE, FALSE))
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
  state <- new.env(parent = emptyenv())
  pkg <- local_test_project()
  readme <- file.path(pkg, "README.qmd")
  writeLines("---\ntitle: Root\n---", readme)

  state$calls <- list()
  local_mocked_bindings(
    build_qmd = function(files, path, ..., quiet = TRUE) {
      state$calls[[length(state$calls) + 1L]] <- list(
        files = files,
        path = path,
        quiet = quiet
      )
      invisible(TRUE)
    }
  )

  expect_true(build_readme_qmd(path = ".", quiet = FALSE))
  expect_length(state$calls, 1)
  expect_equal(state$calls[[1]]$files, normalizePath(readme, winslash = "/"))
  expect_equal(state$calls[[1]]$path, ".")
  expect_false(state$calls[[1]]$quiet)
})

test_that("build_readme_qmd() builds an inst README.qmd", {
  state <- new.env(parent = emptyenv())
  pkg <- local_test_project()
  dir.create(file.path(pkg, "inst"))
  readme <- file.path(pkg, "inst", "README.qmd")
  writeLines("---\ntitle: Inst\n---", readme)

  state$calls <- list()
  local_mocked_bindings(
    build_qmd = function(files, path, ..., quiet = TRUE) {
      state$calls[[length(state$calls) + 1L]] <- list(
        files = files,
        path = path
      )
      invisible(TRUE)
    }
  )

  expect_true(build_readme_qmd(path = "."))
  expect_length(state$calls, 1)
  expect_equal(state$calls[[1]]$files, normalizePath(readme, winslash = "/"))
  expect_equal(state$calls[[1]]$path, ".")
})
