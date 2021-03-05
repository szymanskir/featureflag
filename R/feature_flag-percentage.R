#' Function returning the class of a percentage feature flag.
#'
#' @noRd
#'
.percentage_feature_flag_class <- function() {
  "percentage_feature_flag"
}


create_percentage_feature_flag <- function(percentage) {
  assert(length(percentage) == 1)
  assert(percentage >= 0 && percentage <= 1)

  flag <- create_feature_flag()
  flag$percentage <- percentage

  prepend_class(flag, .percentage_feature_flag_class())
}


is_percentage_feature_flag <- function(feature_flag) {
  inherits(feature_flag, .percentage_feature_flag_class())
}


is_enabled.percentage_feature_flag <- function(feature_flag) {
  is_percentage_feature_flag(feature_flag)

  random_value <- runif(n = 1, min = 0, max = 1)
  random_value <= feature_flag$percentage
}
