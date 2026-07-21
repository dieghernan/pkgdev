test_that("add_global_gitgnore() records package ignore rules", {
  pkg <- local_test_package()
  withr::local_dir(pkg)
  dir.create(file.path(pkg, "revdep"))
  dir.create(file.path(pkg, "vignettes", "articles"), recursive = TRUE)
  writeLines(
    "---\ntitle: Vignette\n---",
    file.path(pkg, "vignettes", "test.qmd")
  )
  writeLines(
    "---\ntitle: Article\n---",
    file.path(pkg, "vignettes", "articles", "test.qmd")
  )
  writeLines(c("keep", "revdep"), ".gitignore")

  git_ignore <- list()
  build_ignore <- list()
  build_ignore_dir <- list()
  vaccinated <- 0L

  local_mocked_bindings(
    add_global_use_git_ignore = function(ignores, directory = ".") {
      git_ignore[[length(git_ignore) + 1L]] <<- list(
        ignores = ignores,
        directory = directory
      )
    },
    add_global_git_vaccinate = function(...) {
      vaccinated <<- vaccinated + 1L
    },
    add_global_use_build_ignore = function(ignores, ...) {
      build_ignore[[length(build_ignore) + 1L]] <<- ignores
    },
    use_build_ignore_dir = function(paths) {
      build_ignore_dir[[length(build_ignore_dir) + 1L]] <<- paths
    },
    add_global_as_package = function(...) {
      list(package = "testpkg")
    }
  )

  expect_null(add_global_gitgnore(pkg = pkg))

  expect_equal(readLines(".gitignore"), "keep")
  expect_equal(vaccinated, 1L)

  git_ignores <- unlist(lapply(git_ignore, `[[`, "ignores"))
  expect_setequal(
    intersect(git_ignores, c(".Rproj.user", "testpkg.Rcheck/", "*.html")),
    c(".Rproj.user", "testpkg.Rcheck/", "*.html")
  )

  git_dirs <- unlist(lapply(git_ignore, `[[`, "directory"))
  expect_setequal(
    intersect(
      git_dirs,
      c(pkg, file.path(pkg, "revdep"), file.path(pkg, "vignettes"))
    ),
    c(pkg, file.path(pkg, "revdep"), file.path(pkg, "vignettes"))
  )

  expect_setequal(
    intersect(unlist(build_ignore), c("codemeta.json", "CITATION.cff")),
    c("codemeta.json", "CITATION.cff")
  )
  expect_setequal(
    intersect(unlist(build_ignore_dir), c("revdep", "vignettes/articles")),
    c("revdep", "vignettes/articles")
  )
})
