test_that("gha_pkgdown_branch() writes platform and version placeholders", {
  pkg <- local_test_project()

  gha_pkgdown_branch(pkg = ".", platform = "ubuntu", version = "24.04")

  workflow <- file.path(pkg, ".github", "workflows", "pkgdown-gh-pages.yaml")
  lines <- readLines(workflow)
  workflow_yaml <- yaml::read_yaml(workflow)

  expect_equal(file.exists(workflow), TRUE)
  expect_contains(
    names(workflow_yaml),
    c("name", "permissions", "concurrency", "jobs")
  )
  expect_equal(
    workflow_yaml$jobs$`pkgdown-gh-pages`$`runs-on`,
    "ubuntu-24.04"
  )
  expect_equal(any(grepl("runs-on: ubuntu-24.04", lines, fixed = TRUE)), TRUE)
  expect_equal(
    any(grepl("runs-on: <OS>-<version>", lines, fixed = TRUE)),
    FALSE
  )
})

test_that("gha_pkgdown_branch() respects overwrite = FALSE", {
  pkg <- local_test_project()
  dir.create(file.path(pkg, ".github", "workflows"), recursive = TRUE)
  workflow <- file.path(pkg, ".github", "workflows", "pkgdown-gh-pages.yaml")
  writeLines("existing workflow", workflow)

  gha_pkgdown_branch(pkg = ".", overwrite = FALSE)

  expect_equal(readLines(workflow), "existing workflow")
})
