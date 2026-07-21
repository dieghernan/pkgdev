test_that("precompute_vignette_all() precomputes every orig vignette", {
  pkg <- local_test_package()
  dir.create(file.path(pkg, "vignettes"))
  writeLines("Rmd", file.path(pkg, "vignettes", "one.Rmd.orig"))
  writeLines("qmd", file.path(pkg, "vignettes", "two.qmd.orig"))
  writeLines("plain", file.path(pkg, "vignettes", "three.Rmd"))

  calls <- list()
  local_mocked_bindings(
    precompute_vignette = function(source, pkg, ...) {
      calls[[length(calls) + 1L]] <<- list(source = source, pkg = pkg)
    }
  )

  precompute_vignette_all(pkg = pkg)

  expect_length(calls, 1)
  expect_equal(calls[[1]]$source, c("one.Rmd.orig", "two.qmd.orig"))
  expect_equal(calls[[1]]$pkg, pkg)
})

test_that("precompute_vignette_all() is quiet when no orig vignettes exist", {
  pkg <- local_test_package()
  dir.create(file.path(pkg, "vignettes"))
  writeLines("plain", file.path(pkg, "vignettes", "plain.Rmd"))

  calls <- 0L
  local_mocked_bindings(
    precompute_vignette = function(...) {
      calls <<- calls + 1L
    }
  )

  precompute_vignette_all(pkg = pkg)

  expect_equal(calls, 0L)
})

test_that("precompute_vignette_all() respects custom vignette directories", {
  pkg <- local_test_package()
  dir.create(file.path(pkg, "articles"))
  writeLines("article", file.path(pkg, "articles", "article.qmd.orig"))

  calls <- list()
  local_mocked_bindings(
    precompute_vignette = function(source, pkg, ...) {
      calls[[length(calls) + 1L]] <<- list(source = source, pkg = pkg)
    }
  )

  precompute_vignette_all(dir = "articles", pkg = pkg)

  expect_length(calls, 1)
  expect_equal(calls[[1]]$source, "article.qmd.orig")
  expect_equal(calls[[1]]$pkg, pkg)
})

test_that("precompute_vignette() writes a precomputed R Markdown vignette", {
  pkg <- local_test_project()
  withr::local_envvar(R_USER_CACHE_DIR = withr::local_tempdir())
  dir.create(file.path(pkg, "vignettes"))
  writeLines(
    c(
      "---",
      "title: Test vignette",
      "output: md_document",
      "---",
      "",
      "Text."
    ),
    file.path(pkg, "vignettes", "test.Rmd.orig")
  )

  precompute_vignette("test.Rmd.orig", pkg = ".")

  expect_equal(file.exists(file.path(pkg, "vignettes", "test.Rmd")), TRUE)
  expect_equal(
    any(grepl(
      "vignettes.*test.*Rmd.*orig",
      readLines(file.path(pkg, ".Rbuildignore"))
    )),
    TRUE
  )
  expect_equal(
    any(grepl(
      "[*][.]html",
      readLines(file.path(pkg, "vignettes", ".gitignore"))
    )),
    TRUE
  )
})
