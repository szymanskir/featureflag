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


test_that("if wrapper has access to variables used in the expression", {
  enabled_flag <- create_bool_feature_flag(value = TRUE)
  expr_frame_variable <- 3

  result <- feature_if(enabled_flag, {
    expr_frame_variable * expr_frame_variable
  })

  expect_equal(result, 9)
})


test_that("ifelse wrapper runs the left expression when flag is enabled", {
  enabled_flag <- create_bool_feature_flag(value = TRUE)

  result <- feature_ifelse(
    enabled_flag,
    1 + 1,
    1 * 1
  )

  expect_equal(result, 2)
})


test_that("ifelse wrapper runs the right expression when flag is disabled", {
  disabled_flag <- create_bool_feature_flag(value = FALSE)

  result <- feature_ifelse(
    disabled_flag,
    1 + 1,
    1 * 1
  )

  expect_equal(result, 1)
})


test_that("ifelse wrapper has access to variables used in the expression", {
  enabled_flag <- create_bool_feature_flag(value = TRUE)

  expr_frame_variable <- 3

  result <- feature_ifelse(
    enabled_flag,
    expr_frame_variable * 2,
    expr_frame_variable * -2
  )

  expect_equal(result, 6)
})
