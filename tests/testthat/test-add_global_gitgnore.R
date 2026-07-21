test_that("add_global_gitgnore() writes package ignore files", {
  pkg <- local_test_project()
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

  vaccinated <- 0L
  local_mocked_bindings(
    add_global_git_vaccinate = function(...) {
      vaccinated <<- vaccinated + 1L
    }
  )

  expect_null(add_global_gitgnore(pkg = "."))
  expect_equal(vaccinated, 1L)

  root_gitignore <- readLines(".gitignore")
  expect_contains(root_gitignore, "keep")
  expect_disjoint(root_gitignore, "revdep")
  expect_contains(
    root_gitignore,
    c(".Rproj.user", "testpkg.Rcheck/", "testpkg*.tar.gz")
  )

  revdep_gitignore <- readLines(file.path("revdep", ".gitignore"))
  expect_contains(revdep_gitignore, c("checks", "library", "*.html"))

  vignette_gitignore <- readLines(file.path("vignettes", ".gitignore"))
  expect_contains(vignette_gitignore, c("/.quarto/", "*_files", "*.html"))

  article_gitignore <- readLines(
    file.path("vignettes", "articles", ".gitignore")
  )
  expect_contains(article_gitignore, c("/.quarto/", "*_files", "*.html"))

  buildignore <- readLines(".Rbuildignore")
  expect_contains(
    buildignore,
    c("^codemeta\\.json$", "^CITATION\\.cff$", "^revdep$", "^revdep/")
  )
})
