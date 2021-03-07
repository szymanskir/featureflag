#' Function returning the class of a time period feature flag.
#'
#' @noRd
#'
.time_period_feature_flag_class <- function() { # nolint
  "time_period_feature_flag"
}

#' Creates an instance of a time period feature flag.
#'
#' @details Boundaries are set as inclusive
#'
#' @param from date-time from which the feature flag should be enabled
#' set as null if you want a one sided boundary.
#'
#' @param to date-time to which the feature flag should be enabled
#' set as null if you want a one sided boundary
#'
#' @export
#'
#'
#' @examples
#' {
#'    two_sided_flag <- create_time_period_feature_flag(
#'       from = ISOdatetime(2020, 10, 10, 0, 0, 0, tz = "UTC"),
#'       to = ISOdatetime(2020, 11, 10, 0, 0, 0, tz = "UTC")
#'    )
#'
#'    left_sided_flag <- create_time_period_feature_flag(
#'       from = ISOdatetime(2020, 10, 10, 0, 0, 0, tz = "UTC")
#'    )
#'
#'    right_sided_flag <- create_time_period_feature_flag(
#'       to = ISOdatetime(2020, 10, 10, 0, 0, 0, tz = "UTC")
#'    )
#'
#' }
#'
create_time_period_feature_flag <- function(from = NULL, to = NULL) { #nolint
  assert(any(!c(is.null(from), is.null(to))), "At least a single boundary has to be defined.")
  assert_null_or_datetime(from)
  assert_null_or_datetime(to)

  feature_flag <- create_feature_flag()
  feature_flag <- prepend_class(feature_flag, .time_period_feature_flag_class())

  feature_flag$from <- from
  feature_flag$to <- to

  feature_flag
}

#' Checks if the given object is an instance of the
#' time period feature flag class.
#'
#' @param feature_flag object to check whether it is an instance
#' of the time period feature flag class
#'
#' @return TRUE if the object is an instance of the time period feature
#' flag class.
#'
#' @noRd
#'
is_time_period_feature_flag <- function(feature_flag) {
  inherits(feature_flag, .time_period_feature_flag_class())
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
#'    feature_flag <- create_time_period_feature_flag(
#'       from = ISOdatetime(2020, 10, 10, 0, 0, 0, tz = "UTC")
#'    )
#'
#'    if (is_enabled(feature_flag)) {
#'       print("The flag is enabled!")
#'    }
#' }
#'
is_enabled.time_period_feature_flag <- function(feature_flag) { # nolint
  is_time_period_feature_flag(feature_flag)

  current_datetime <- Sys.time()

  is_from_boundary_met <- is.null(feature_flag$from) || (feature_flag$from <= current_datetime)
  is_to_boundary_met <- is.null(feature_flag$to) || (feature_flag$to >= current_datetime)

  is_from_boundary_met && is_to_boundary_met
}
