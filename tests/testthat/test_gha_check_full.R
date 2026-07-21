test_that("gha_check_full() writes a scheduled check workflow", {
  pkg <- local_test_project()

  gha_check_full(pkg = ".", cron_expr = "1 2 3 4 5")

  workflow <- file.path(pkg, ".github", "workflows", "check-full.yaml")
  lines <- readLines(workflow)

  expect_equal(file.exists(workflow), TRUE)
  expect_equal(any(grepl('cron: "1 2 3 4 5"', lines, fixed = TRUE)), TRUE)
  expect_equal(any(grepl("ADD_CRON_EXPRESSION", lines, fixed = TRUE)), FALSE)
})

test_that("gha_check_full() leaves existing workflow when overwrite is FALSE", {
  pkg <- local_test_project()
  dir.create(file.path(pkg, ".github", "workflows"), recursive = TRUE)
  workflow <- file.path(pkg, ".github", "workflows", "check-full.yaml")
  writeLines("existing workflow", workflow)

  gha_check_full(pkg = ".", overwrite = FALSE)

  expect_equal(readLines(workflow), "existing workflow")
})
