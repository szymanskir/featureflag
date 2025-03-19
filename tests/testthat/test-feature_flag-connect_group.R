test_that("connect group feature flag create method checks the correctness of arguments", {
  expect_snapshot_error(create_connect_group_feature_flag(c(1, 2, 3)))
  expect_snapshot_error(create_connect_group_feature_flag(NULL))
  expect_snapshot_error(create_connect_group_feature_flag(NA))
})


test_that("connect group feature flag returns FALSE when groups field is NULL", {
  # Arrange
  mock_session <- shiny::MockShinySession$new()
  mock_session$groups <- NULL
  feature_flag <- create_connect_group_feature_flag(groups = c("group1"))

  # Act and Assert
  shiny::withReactiveDomain(
    domain = mock_session,
    expr = {
      expect_false(is_enabled(feature_flag))
    }
  )
})


test_that("connect group feature flag returns TRUE if user belongs to any specified group", {
  # Arrange
  mock_session <- shiny::MockShinySession$new()
  mock_session$groups <- "group1"
  feature_flag <- create_connect_group_feature_flag(groups = c("group1"))

  # Act and Assert
  shiny::withReactiveDomain(
    domain = mock_session,
    expr = {
      expect_true(is_enabled(feature_flag))
    }
  )
})

test_that("connect group feature flag returns FALSE if user does not belong to any specified group", {
  # Arrange
  mock_session <- shiny::MockShinySession$new()
  mock_session$groups <- "group2"
  feature_flag <- create_connect_group_feature_flag(groups = c("group1"))

  # Act and Assert
  shiny::withReactiveDomain(
    domain = mock_session,
    expr = {
      expect_false(is_enabled(feature_flag))
    }
  )
})

test_that("connect group feature flag returns TRUE if any user group is a specified group", {
  # Arrange
  mock_session <- shiny::MockShinySession$new()
  mock_session$groups <- c("group1", "group2")
  feature_flag <- create_connect_group_feature_flag(groups = c("group1", "group3"))

  # Act and Assert
  shiny::withReactiveDomain(
    domain = mock_session,
    expr = {
      expect_true(is_enabled(feature_flag))
    }
  )
})

test_that("connect group feature flag throws an error if checked outside of a reactive domain", {
  # Arrange
  feature_flag <- create_connect_group_feature_flag(groups = c("group1"))

  # Act and Assert
  expect_snapshot_error(
    x = is_enabled(feature_flag)
  )
})

test_that("connect group feature flag throws an error if shiny is not available", {
  # Arrange
  local_mocked_bindings(is_shiny_available = function() FALSE)
  feature_flag <- create_connect_group_feature_flag(groups = c("group1"))

  # Act and Assert
  expect_snapshot_error(
    x = is_enabled(feature_flag)
  )
})
