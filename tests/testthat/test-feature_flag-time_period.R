test_that("Time period feature flags are enabled within specified boundaries", {
  feature_flag <- create_time_period_feature_flag(
    from = ISOdatetime(2020, 1, 1, 10, 0, 0, tz = "UTC"),
    to = ISOdatetime(2020, 1, 1, 13, 0, 0, tz = "UTC")
  )

  sys_time_stub <- function() ISOdatetime(2020, 1, 1, 12, 0, 0, tz = "UTC")
  local_mocked_bindings(get_current_time = sys_time_stub)

  expect_true(is_enabled(feature_flag))
})


test_that("Time period feature flags are disabled when not in specified boundaries", {
  feature_flag <- create_time_period_feature_flag(
    from = ISOdatetime(2020, 1, 1, 10, 0, 0, tz = "UTC"),
    to = ISOdatetime(2020, 1, 1, 13, 0, 0, tz = "UTC")
  )

  sys_time_stub <- function() ISOdatetime(2020, 1, 1, 15, 0, 0, tz = "UTC")
  local_mocked_bindings(get_current_time = sys_time_stub)

  expect_false(is_enabled(feature_flag))
})

test_that("Time period feature flags bounded from are enabled from specified boundry", {
  feature_flag <- create_time_period_feature_flag(
    from = ISOdatetime(2020, 1, 1, 10, 0, 0, tz = "UTC")
  )

  sys_time_stub <- function() ISOdatetime(2920, 1, 1, 15, 0, 0, tz = "UTC")
  local_mocked_bindings(get_current_time = sys_time_stub)

  expect_true(is_enabled(feature_flag))
})


test_that("Time period feature flags bounded from are disabled to specified boundry", {
  feature_flag <- create_time_period_feature_flag(
    from = ISOdatetime(2020, 1, 1, 10, 0, 0, tz = "UTC")
  )

  sys_time_stub <- function() ISOdatetime(2020, 1, 1, 9, 59, 59, tz = "UTC")
  local_mocked_bindings(get_current_time = sys_time_stub)

  expect_false(is_enabled(feature_flag))
})


test_that("Time period feature flags bounded `to` are enabled until specified boundry", {
  feature_flag <- create_time_period_feature_flag(
    to = ISOdatetime(2020, 1, 1, 10, 0, 0, tz = "UTC")
  )

  sys_time_stub <- function() ISOdatetime(1990, 1, 1, 9, 0, 0, tz = "UTC")
  local_mocked_bindings(get_current_time = sys_time_stub)

  expect_true(is_enabled(feature_flag))
})


test_that("Time period feature flags bounded to are disabled from specified boundry", {
  feature_flag <- create_time_period_feature_flag(
    to = ISOdatetime(2020, 1, 1, 10, 0, 0, tz = "UTC")
  )

  sys_time_stub <- function() ISOdatetime(2020, 1, 1, 10, 59, 59, tz = "UTC")
  local_mocked_bindings(get_current_time = sys_time_stub)

  expect_false(is_enabled(feature_flag))
})
