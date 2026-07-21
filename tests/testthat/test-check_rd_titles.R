test_that("check_rd_titles() returns NULL when no Rd files exist", {
  pkg <- local_test_package()

  expect_null(check_rd_titles(pkg))
})

test_that("check_rd_titles() reports Rd title metadata", {
  pkg <- local_test_package()
  rd <- write_rd(
    pkg,
    "topic",
    c(
      "\\name{topic}",
      "\\title{A title.}",
      "\\description{A description.}"
    )
  )

  titles <- check_rd_titles(pkg)

  expect_s3_class(titles, "data.frame")
  expect_equal(titles$src, rd)
  expect_equal(titles$title, "A title.")
  expect_equal(titles$last, ".")
  expect_equal(titles$check_case, TRUE)
})
