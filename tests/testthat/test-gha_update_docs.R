test_that("gha_update_docs() writes platform and version placeholders", {
  pkg <- local_test_project()

  gha_update_docs(pkg = ".", platform = "windows", version = "latest")

  workflow <- file.path(pkg, ".github", "workflows", "update-docs.yaml")
  lines <- readLines(workflow)
  workflow_yaml <- yaml::read_yaml(workflow)

  expect_true(file.exists(workflow))
  expect_contains(
    names(workflow_yaml),
    c("name", "permissions", "concurrency", "jobs")
  )
  expect_equal(
    workflow_yaml$jobs$`update-docs`$`runs-on`,
    "windows-latest"
  )
  expect_true(any(grepl("runs-on: windows-latest", lines, fixed = TRUE)))
  expect_false(any(grepl("runs-on: <OS>-<version>", lines, fixed = TRUE)))
})

test_that("gha_update_docs() errors when overwrite is FALSE", {
  pkg <- local_test_project()
  dir.create(file.path(pkg, ".github", "workflows"), recursive = TRUE)
  workflow <- file.path(pkg, ".github", "workflows", "update-docs.yaml")
  writeLines("existing workflow", workflow)

  expect_error(
    gha_update_docs(pkg = ".", overwrite = FALSE),
    class = "pkgdev_workflow_copy_error"
  )

  expect_equal(readLines(workflow), "existing workflow")
})
