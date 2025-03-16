test_that("connect  user feature flag create method checks the correctness of arguments", {
  expect_error(create_connect_user_feature_flag(c(1, 2, 3)))
  expect_error(create_connect_user_feature_flag(NULL))
})


test_that("connect user feature flag returns FALSE when user is NULL", {
  # Arrange
  mock_session <- shiny::MockShinySession$new()
  mock_session$user <- NULL
  feature_flag <- create_connect_user_feature_flag(users = c("user1"))

  # Act and Assert
  shiny::withReactiveDomain(
    domain = mock_session,
    expr = {
      expect_false(is_enabled(feature_flag))
    }
  )
})

test_that("connect user feature flag returns TRUE for specified users", {
  # Arrange
  mock_session <- shiny::MockShinySession$new()
  mock_session$user <- "user1"
  feature_flag <- create_connect_user_feature_flag(users = c("user1"))

  # Act and Assert
  shiny::withReactiveDomain(
    domain = mock_session,
    expr = {
      expect_true(is_enabled(feature_flag))
    }
  )
})

test_that("connect user feature flag returns FALSE for unspecified users", {
  # Arrange
  mock_session <- shiny::MockShinySession$new()
  mock_session$user <- "user2"
  feature_flag <- create_connect_user_feature_flag(users = c("user1"))

  # Act and Assert
  shiny::withReactiveDomain(
    domain = mock_session,
    expr = {
      expect_false(is_enabled(feature_flag))
    }
  )
})

test_that("connect user feature flag throws an error if checked outside of a reactive domain", {
  # Arrange
  feature_flag <- create_connect_user_feature_flag(users = c("user1"))

  # Act and Assert
  expect_snapshot_error(
    x = is_enabled(feature_flag)
  )
})

test_that("connect user feature flag throws an error if shiny is not available", {
  # Arrange
  local_mocked_bindings(is_shiny_available = function() FALSE)
  feature_flag <- create_connect_user_feature_flag(users = c("user1"))

  # Act and Assert
  expect_snapshot_error(
    x = is_enabled(feature_flag)
  )
})
