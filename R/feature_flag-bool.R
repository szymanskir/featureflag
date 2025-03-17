#' Function returning the class of a bool feature flag.
#'
#' @noRd
#'
.bool_feature_flag_class <- function() {
  "bool_feature_flag"
}

#' Creates an instance of a bool feature flag
#' with the specified bool value.
#'
#' @param value single logical determining whether the
#' flag should be enabled
#'
#' @export
#'
#' @return feature flag object of the bool value
#'
#' @examples
#' {
#'   enabled_flag <- create_bool_feature_flag(TRUE)
#'   disabled_flag <- create_bool_feature_flag(FALSE)
#' }
create_bool_feature_flag <- function(value) {
  assert(
    is.logical(value) && length(value) == 1,
    error = "'value' should be a logical of length 1"
  )

  flag <- create_feature_flag()
  flag$value <- value

  prepend_class(flag, .bool_feature_flag_class())
}

#' Checks if the given object is an instance of the
#' bool feature flag class.
#'
#' @param feature_flag object to check whether it is an instance
#' of the bool feature flag class
#'
#' @return TRUE if the object is an instance of the bool feature
#' flag class.
#'
#' @noRd
#'
is_bool_feature_flag <- function(feature_flag) {
  inherits(feature_flag, .bool_feature_flag_class())
}

#' Checks if the given bool feature flag is enabled
#'
#' @param feature_flag flag to be checked whether it is
#' enabled
#'
#' @return TRUE if the feature flag is enabled.
#'
#' @export
#'
#' @examples
#' {
#'   enabled_flag <- create_bool_feature_flag(TRUE)
#'
#'   if (is_enabled(enabled_flag)) {
#'     print("The flag is enabled!")
#'   }
#' }
is_enabled.bool_feature_flag <- function(feature_flag) { # nolint
  stopifnot(is_bool_feature_flag(feature_flag))
  feature_flag$value
}
