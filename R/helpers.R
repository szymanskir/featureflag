#' Evaluates the provided expression if the feature flag
#' is enabled.
#'
#' @param feature_flag flag which defines whether the provided
#' expression should be evaluated
#'
#' @param expr expression to evaluate when the feature_flag is enabled
#'
#' @export
#'
#' @examples
#' {
#'   flag <- create_bool_feature_flag(TRUE)
#'
#'   feature_if(flag, {2 + 7})
#' }
#'
feature_if <- function(feature_flag, expr) {
  assert_feature_flag_class(feature_flag)

  expr <- substitute(expr)

  if (is_enabled(feature_flag)) {
    expr_frame <- parent.frame() # frame in which the expression was defined
    eval(expr = expr, envir = expr_frame)
  }
}


#' Evaluates one or the other expression based on whether the feature flag
#' is enabled.
#'
#' @param feature_flag flag which defines which expression should be
#' evaluated
#'
#' @param true_expr expression to evaluate when the feature_flag is enabled
#'
#' @param false_expr expression to evaluate when the feature_flag is disabled
#'
#' @export
#'
#' @examples
#' {
#'   flag <- create_bool_feature_flag(TRUE)
#'
#'   feature_ifelse(
#'     flag, {
#'       2 * 7
#'     }, {
#'       3 * 7
#'     }
#'   )
#' }
#'
feature_ifelse <- function(feature_flag, true_expr, false_expr) {
  assert_feature_flag_class(feature_flag)

  true_expr <- substitute(true_expr)
  false_expr <- substitute(false_expr)


  if (is_enabled(feature_flag)) {
    expr_to_eval <- true_expr
  } else {
    expr_to_eval <- false_expr
  }

  expr_frame <- parent.frame() # frame in which the expression was defined
  eval(expr = expr_to_eval, envir = expr_frame)
}
