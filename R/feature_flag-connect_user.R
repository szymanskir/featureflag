#' Function returning the class of a connect user feature flag.
#'
#' @noRd
#'
.connect_user_feature_flag_class <- function() {
  "connect_user_feature_flag"
}

#' Creates an instance of a connect feature flag
#' with the specified bool value.
#'
#' @param users users for which the feature flag
#' should be enabled
#'
#' @export
#'
#' @return feature flag that is enabled for specific users
#'
#' @examples
#' {
#'   connect_user_flag <- create_connect_user_feature_flag(users = c("user1", "user2"))
#' }
create_connect_user_feature_flag <- function(users) {
  assert(is.character(users), "'users' should be a vector of characters")

  flag <- create_feature_flag()
  flag$users <- users

  prepend_class(flag, .connect_user_feature_flag_class())
}

#' Checks if the given object is an instance of the
#' connect user feature flag class.
#'
#' @param feature_flag object to check whether it is an instance
#' of the connect user feature flag class
#'
#' @return TRUE if the object is an instance of the connect user feature
#' flag class.
#'
#' @noRd
#'
is_connect_user_feature_flag <- function(feature_flag) {
  inherits(feature_flag, .connect_user_feature_flag_class())
}

#' Checks if the given connect user feature flag is enabled
#'
#' @param feature_flag flag to be checked whether it is
#' enabled
#'
#' @return TRUE if the feature flag is enabled.
#'
#' @details
#' The session$user field is used for retrieving the information
#' on the logged-in user
#'
#' @export
#'
#' @examples
#' {
#'   flag <- create_connect_user_feature_flag(c("user1"))
#'
#'   # Returns TRUE if the session$user matches the specified users
#'   mock_session <- shiny::MockShinySession$new()
#'   mock_session$user <- "user1"
#'   shiny::withReactiveDomain(
#'     domain = mock_session,
#'     expr = is_enabled(flag)
#'   )
#'
#'   # Returns FALSE if the session$user does not matche the specified users
#'   mock_session <- shiny::MockShinySession$new()
#'   mock_session$user <- "user2"
#'   shiny::withReactiveDomain(
#'     domain = mock_session,
#'     expr = is_enabled(flag)
#'   )
#' }
is_enabled.connect_user_feature_flag <- function(feature_flag) { # nolint
  stopifnot(is_connect_user_feature_flag(feature_flag))
  assert_shiny_available()

  session <- shiny::getDefaultReactiveDomain()

  if (is.null(session)) {
    stop("connect user feature flags need to be evaluated within a reactive context")
  }

  base::isTRUE(session$user %in% feature_flag$users)
}
