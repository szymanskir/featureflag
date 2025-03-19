#' Function returning the class of a connect group feature flag.
#'
#' @noRd
#'
.connect_group_feature_flag_class <- function() {
  "connect_group_feature_flag"
}

#' Creates an instance of a connect feature flag
#' that is enabled for specific groups
#'
#' @param groups groups for which the feature flag
#' should be enabled
#'
#' @export
#'
#' @return feature flag that is enabled for specific groups
#'
#' @examples
#' {
#'   connect_group_flag <- create_connect_group_feature_flag(groups = c("group1", "group2"))
#' }
create_connect_group_feature_flag <- function(groups) {
  assert(is.character(groups), "'groups' should be a vector of characters")

  flag <- create_feature_flag()
  flag$groups <- groups

  prepend_class(flag, .connect_group_feature_flag_class())
}

#' Checks if the given object is an instance of the
#' connect group feature flag class.
#'
#' @param feature_flag object to check whether it is an instance
#' of the connect group feature flag class
#'
#' @return TRUE if the object is an instance of the connect group feature
#' flag class.
#'
#' @noRd
#'
is_connect_group_feature_flag <- function(feature_flag) {
  inherits(feature_flag, .connect_group_feature_flag_class())
}

#' Checks if the given connect group feature flag is enabled
#'
#' @param feature_flag flag to be checked whether it is
#' enabled
#'
#' @return TRUE if the logged in user belongs to a group defined
#' in the feature flag
#'
#' @details
#' The session$groups field is used for retrieving the information
#' on the logged-in user groups
#'
#' @export
#'
#' @examples
#' {
#'   flag <- create_connect_group_feature_flag(c("group1"))
#'
#'   # Returns TRUE when the logged-in user belongs to at least one of the specified groups
#'   mock_session <- shiny::MockShinySession$new()
#'   mock_session$groups <- "group1"
#'   shiny::withReactiveDomain(
#'     domain = mock_session,
#'     expr = is_enabled(flag)
#'   )
#'
#'   # Returns FALSE if session$groups does not have any of the specified groups
#'   mock_session <- shiny::MockShinySession$new()
#'   mock_session$user <- "group2"
#'   shiny::withReactiveDomain(
#'     domain = mock_session,
#'     expr = is_enabled(flag)
#'   )
#' }
is_enabled.connect_group_feature_flag <- function(feature_flag) { # nolint
  stopifnot(is_connect_group_feature_flag(feature_flag))
  assert_shiny_available()

  session <- shiny::getDefaultReactiveDomain()

  if (is.null(session)) {
    stop("connect group feature flags need to be evaluated within a reactive context")
  }

  any(session$groups %in% feature_flag$groups, na.rm = TRUE)
}
