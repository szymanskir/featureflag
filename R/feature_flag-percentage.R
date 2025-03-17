#' Function returning the class of a percentage feature flag.
#'
#' @noRd
#'
.percentage_feature_flag_class <- function() {
  "percentage_feature_flag"
}

#' Creates an instance of a percentage feature flag
#' with a specified chance of being enabled
#'
#' @param percentage chance of being enabled e.g. 1 for always
#' being enabled
#'
#' @return feature flag object of the percentage type
#'
#' @export
#'
#' @examples
#' {
#'   always_enabled_flag <- create_percentage_feature_flag(percentage = 1)
#'   randomly_enabled_flag <- create_percentage_feature_flag(percentage = 0.5)
#' }
create_percentage_feature_flag <- function(percentage) {
  assert(
    length(percentage) == 1 && is.numeric(percentage),
    "'percentage' should be a numeric of length 1"
  )
  assert(
    percentage >= 0 && percentage <= 1,
    "'percentage' should be a value from 0 to 1"
  )

  flag <- create_feature_flag()
  flag$percentage <- percentage

  prepend_class(flag, .percentage_feature_flag_class())
}

#' Checks if the given object is an instance of the
#' percentage feature flag class
#'
#' @param feature_flag object to check whether it is an instance
#' of the percentage feature flag class
#'
#' @return TRUE if the object is an instance of the percentage feature
#' flag class.
#'
#' @noRd
#'
is_percentage_feature_flag <- function(feature_flag) {
  inherits(feature_flag, .percentage_feature_flag_class())
}

#' Checks if the given percentage flag is enabled
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
#'   enabled_flag <- create_percentage_feature_flag(1)
#'
#'   if (is_enabled(enabled_flag)) {
#'     print("The flag is enabled!")
#'   }
#' }
is_enabled.percentage_feature_flag <- function(feature_flag) { # nolint
  is_percentage_feature_flag(feature_flag)

  random_value <- get_random_value()
  random_value <= feature_flag$percentage
}

#' Samples a value from the uniform distribution
#' @noRd
#'
get_random_value <- function() {
  stats::runif(n = 1, min = 0, max = 1)
}
