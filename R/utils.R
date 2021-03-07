#' Asserts a given expression and throws an error
#' if it returns FALSE
#'
#' @param expression R expression to be evaluated
#'
#' @param error message to be displayed when the
#' expression is not fulfilled
#'
#' @noRd
#'
assert <- function(expression, error) {
  if (!expression) {
    stop(error, call. = FALSE)
  }
}

#' Prepends the class attribute of the passed object with the
#' passed class name.
#'
#' @param x object whose class attribute should be prepended
#' with the passed class_name
#'
#' @param class_name name of the class to prepend with
#'
#' @noRd
#'
prepend_class <- function(x, class_name) {
  class(x) <- c(class_name, class(x))
  x
}


#' Checks if the provided object is null or a non NA datetime object.
#'
#' @param x object to be tested
#'
#' @noRd
#'
null_or_datetime <- function(x) {
  assert(length(x) <= 1, "Checked argument should be at most a single element")
  is.null(x) || (inherits(x, "POSIXct") && !is.na.POSIXlt(x))
}


#' Asserts whether the provided object is null or a non NA datetime object
#'
#' @param x object to be tested
#'
#' @noRd
#'
assert_null_or_datetime <- function(x) {
  assert(null_or_datetime(x), "Object should be NULL or a non NA datetime instance")
}
