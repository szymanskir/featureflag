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
