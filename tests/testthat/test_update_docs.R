test_that("env_var_is_true() reads logical environment values", {
  withr::local_envvar(
    PKGDEV_TEST_TRUE = "true",
    PKGDEV_TEST_FALSE = "false",
    PKGDEV_TEST_ONE = "1",
    PKGDEV_TEST_EMPTY = ""
  )

  expect_equal(env_var_is_true("PKGDEV_TEST_TRUE"), TRUE)
  expect_equal(env_var_is_true("PKGDEV_TEST_FALSE"), FALSE)
  expect_equal(env_var_is_true("PKGDEV_TEST_ONE"), FALSE)
  expect_equal(env_var_is_true("PKGDEV_TEST_EMPTY"), FALSE)
  expect_equal(env_var_is_true("PKGDEV_TEST_MISSING"), FALSE)
})
