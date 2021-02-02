test_that("if wrapper evaluates the expression when the feature flag is enabled", {
  enabled_flag <- create_bool_feature_flag(value = TRUE)

  result <- feature_if(enabled_flag, {
    2 * 7
  })

  expect_equal(result, 14)
})


test_that("if wrapper ommits the evaluation of the expression when the feature flag is disabled", {
  disabled_flag <- create_bool_feature_flag(value = FALSE)

  result <- feature_if(disabled_flag, {
    2 * 7
  })

  expect_equal(result, NULL)
})


test_that("ifelse wrapper runs the left expression when flag is enabled", {
  enabled_flag <- create_bool_feature_flag(value = TRUE)

  result <- feature_ifelse(
    enabled_flag,
    {
      1 + 1
    },
    {
      1 * 1
    }
  )

  expect_equal(result, 2)
})


test_that("ifelse wrapper runs the right expression when flag is disabled", {
  disabled_flag <- create_bool_feature_flag(value = FALSE)

  result <- feature_ifelse(
    disabled_flag,
    {
      1 + 1
    },
    {
      1 * 1
    }
  )

  expect_equal(result, 1)
})
