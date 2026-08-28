test_that("env_var_is_true() reads logical environment values", {
  withr::local_envvar(
    PKGDEV_TEST_TRUE = "true",
    PKGDEV_TEST_FALSE = "false",
    PKGDEV_TEST_ONE = "1",
    PKGDEV_TEST_EMPTY = ""
  )

  expect_true(env_var_is_true("PKGDEV_TEST_TRUE"))
  expect_false(env_var_is_true("PKGDEV_TEST_FALSE"))
  expect_false(env_var_is_true("PKGDEV_TEST_ONE"))
  expect_false(env_var_is_true("PKGDEV_TEST_EMPTY"))
  expect_false(env_var_is_true("PKGDEV_TEST_MISSING"))
})
