#' @noRd
#'
.time_period_feature_flag_class <- function() {
  "time_period_feature_flag"
}

#' @export
#'
create_time_period_feature_flag <- function(from=NULL, to=NULL) {
  assert(any(!c(is.null(from), is.null(to))), "At least a single boundary has to be defined.")
  assert_null_or_datetime(from)
  assert_null_or_datetime(to)

  feature_flag <- create_feature_flag()
  feature_flag <- prepend_class(feature_flag, .time_period_feature_flag_class())

  feature_flag$from <- from
  feature_flag$to <- to

  feature_flag
}

#' @export
#'
is_time_period_feature_flag <- function(feature_flag) {
  inherits(feature_flag, .time_period_feature_flag_class())
}

#' @export
#'
is_enabled.time_period_feature_flag <- function(feature_flag) { # nolint
  is_time_period_feature_flag(feature_flag)

  current_datetime <- Sys.time()

  is_from_boundary_met <- is.null(feature_flag$from) || (feature_flag$from <= current_datetime)
  is_to_boundary_met <- is.null(feature_flag$to) || (feature_flag$to >= current_datetime)

  is_from_boundary_met && is_to_boundary_met
}
