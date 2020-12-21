test_that("bool feature flag create method checks the correctness of arguments", {
  expect_error(create_bool_feature_flag("a"))
  expect_error(create_bool_feature_flag(1))
  expect_error(create_bool_feature_flag(c(TRUE, FALSE)))
})

test_that("bool feature flag is enabled when its value is set to TRUE", {
  flag <- create_bool_feature_flag(TRUE)
  expect_true(is_enabled(flag))
})


test_that("bool feature flag is disabled when its value is set to FALSE", {
  flag <- create_bool_feature_flag(FALSE)
  expect_false(is_enabled(flag))
})
