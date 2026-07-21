test_that("check_rd_hash() returns NULL when no Rd files exist", {
  pkg <- local_test_package()

  expect_null(check_rd_hash(pkg))
})

test_that("check_rd_hash() flags leaked roxygen comment markers", {
  pkg <- local_test_package()
  clean <- write_rd(
    pkg,
    "clean",
    c(
      "\\name{clean}",
      "\\title{Clean title}",
      "\\description{A description.}"
    )
  )
  dirty <- write_rd(
    pkg,
    "dirty",
    c(
      "\\name{dirty}",
      "\\title{Dirty title}",
      "\\description{Contains #'.}"
    )
  )

  hashes <- check_rd_hash(pkg)

  expect_s3_class(hashes, "data.frame")
  expect_equal(hashes$src, c(clean, dirty))
  expect_equal(hashes$bad_hash, c(FALSE, TRUE))
})
