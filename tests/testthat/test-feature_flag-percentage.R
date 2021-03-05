test_that("Percentage feature flag is enabled when random value is lower than threshold", {
  feature_flag <- create_percentage_feature_flag(percentage = 0.7)
  mockery::stub(is_enabled.percentage_feature_flag, "stats::runif", function(...) 0.3)

  result <- is_enabled(feature_flag)

  expect_true(result)
})


test_that("Percentage feature flag is disabled when random value is higher than threshold", {
  feature_flag <- create_percentage_feature_flag(percentage = 0.7)
  mockery::stub(is_enabled.percentage_feature_flag, "stats::runif", function(...) 0.8)

  result <- is_enabled(feature_flag)

  expect_false(result)
})
