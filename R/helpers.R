#' Evaluates the provided expression if the feature flag
#' is enabled.
#'
#' @param feature_flag flag which defines whether the provided
#' expression should be evaluated
#'
#' @param expr expression to evalute when the feature_flag is enabled
#'
#' @export
#'
feature_if <- function(feature_flag, expr) {
  assert_feature_flag_class(feature_flag)

  expr <- substitute(expr)

  if (is_enabled(feature_flag)) {
    eval(expr = expr)
  }
}


#' Evaluates one or the other expression based on whether the feature flag
#' is enabled.
#'
#' @param feature_flag flag which defines which expression should be
#' evaluated
#'
#' @param true_expr expression to evalute when the feature_flag is enabled
#'
#' @param false_expr expression to evalute when the feature_flag is disabled
#'
#' @export
#'
feature_ifelse <- function(feature_flag, true_expr, false_expr) {
  assert_feature_flag_class(feature_flag)

  true_expr <- substitute(true_expr)
  false_expr <- substitute(false_expr)

  if (is_enabled(feature_flag)) {
    eval(expr = true_expr)
  } else {
    eval(expr = false_expr)
  }
}
