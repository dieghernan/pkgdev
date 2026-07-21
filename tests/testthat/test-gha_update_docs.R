test_that("gha_update_docs() writes platform and version placeholders", {
  pkg <- local_test_project()

  gha_update_docs(pkg = ".", platform = "windows", version = "latest")

  workflow <- file.path(pkg, ".github", "workflows", "update-docs.yaml")
  lines <- readLines(workflow)

  expect_equal(file.exists(workflow), TRUE)
  expect_equal(any(grepl("runs-on: windows-latest", lines, fixed = TRUE)), TRUE)
  expect_equal(
    any(grepl("runs-on: <OS>-<version>", lines, fixed = TRUE)),
    FALSE
  )
})

test_that("gha_update_docs() respects overwrite = FALSE", {
  pkg <- local_test_project()
  dir.create(file.path(pkg, ".github", "workflows"), recursive = TRUE)
  workflow <- file.path(pkg, ".github", "workflows", "update-docs.yaml")
  writeLines("existing workflow", workflow)

  gha_update_docs(pkg = ".", overwrite = FALSE)

  expect_equal(readLines(workflow), "existing workflow")
})
