test_that("env var feature flag create method checks the correctness of arguments", {
  expect_snapshot_error(create_env_var_feature_flag(1))
  expect_snapshot_error(create_env_var_feature_flag(NULL))
  expect_snapshot_error(create_env_var_feature_flag(NA))
  expect_snapshot_error(create_env_var_feature_flag(c("a", "b")))
})

test_that("env var feature flag is disabled when env var is unset", {
  # Arrange
  flag <- create_env_var_feature_flag(env_var = "FOO")

  # Act and Assert
  expect_false(is_enabled(flag))
})

test_that("env var feature flag is enabled when env var is set to 'TRUE'", {
  # Arrange
  flag <- create_env_var_feature_flag(env_var = "FOO")
  withr::local_envvar(list(FOO = "TRUE"))

  # Act and Assert
  expect_true(is_enabled(flag))
})

test_that("env var feature flag is enabled when env var is set to 'true'", {
  # Arrange
  flag <- create_env_var_feature_flag(env_var = "FOO")
  withr::local_envvar(list(FOO = "true"))

  # Act and Assert
  expect_true(is_enabled(flag))
})

test_that("env var feature flag is disabled when env var is set to 'false'", {
  # Arrange
  flag <- create_env_var_feature_flag(env_var = "FOO")
  withr::local_envvar(list(FOO = "false"))

  # Act and Assert
  expect_false(is_enabled(flag))
})

test_that("env var feature flag is disabled when env var is set to 'FALSE'", {
  # Arrange
  flag <- create_env_var_feature_flag(env_var = "FOO")
  withr::local_envvar(list(FOO = "FALSE"))

  # Act and Assert
  expect_false(is_enabled(flag))
})

test_that("env var feature flag is disabled when env var cannot be coerced to a logical", {
  # Arrange
  flag <- create_env_var_feature_flag(env_var = "FOO")
  withr::local_envvar(list(FOO = "BAR"))

  # Act and Assert
  expect_snapshot_warning(result <- is_enabled(flag))
  expect_false(result)
})
