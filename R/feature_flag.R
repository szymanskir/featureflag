#' Function returning the class of a feature flag.
#'
#' @noRd
#'
.feature_flag_class <- function() {
  "feature_flag"
}

#' Creates the base of a feature flag.
#'
#' It should not be used directly, but only
#' as a prerequisite when creating concrete feature flag.
#'
#' @return instance of a base feature flag.
#'
#' @export
#'
create_feature_flag <- function() {
  structure(
    list(),
    class = .feature_flag_class()
  )
}

#' Checks if the given object is an instance of the
#' feature flag class.
#'
#' @return TRUE if the object is an instance of the feature
#' flag class.
#'
#' @noRd
#'
is_feature_flag <- function(feature_flag) {
  inherits(feature_flag, .feature_flag_class())
}

#' Asserts if the given object is an instance
#' of the feature flag class.
#'
#' @noRd
#'
assert_feature_flag_class <- function(feature_flag) {
  assert(
    is_feature_flag(feature_flag),
    sprintf("The object must be an instance of the %s class", .feature_flag_class())
  )
}

#' Checks if the given feature flag is enabled.
#'
#' @return TRUE if the feature flag is enabled.
#'
#' @export
#'
is_enabled <- function(feature_flag) {
  assert_feature_flag_class(feature_flag)
  UseMethod("is_enabled")
}
