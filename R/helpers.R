#' Evaluates the provided expression if the feature flag
#' is enabled.
#'
#' @details The passed expression is evaluated in the frame where `feature_if`
#' is called.
#'
#' @param feature_flag flag which defines whether the provided
#' expression should be evaluated
#'
#' @param expr expression to evaluate when the feature_flag is enabled
#'
#' @return If the passed `feature_flag` is enabled, than the result of the evaluation
#' of the passed expression is returned. Otherwise there is no return value.
#'
#' @export
#'
#' @examples
#' {
#'   flag <- create_bool_feature_flag(TRUE)
#'
#'   feature_if(flag, {
#'     2 + 7
#'   })
#' }
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
#' @details The passed expression is evaluated in the frame where `feature_ifelse`
#' is called.
#'
#' @param feature_flag flag which defines which expression should be
#' evaluated
#'
#' @param true_expr expression to evaluate when the feature_flag is enabled
#'
#' @param false_expr expression to evaluate when the feature_flag is disabled
#'
#' @return The result of evaluating `true_expr` is returned if the passed feature_flag
#' is enabled. Otherwise the result of evaluating `false_expr` is returned.
#'
#' @export
#'
#' @examples
#' {
#'   flag <- create_bool_feature_flag(TRUE)
#'
#'   feature_ifelse(
#'     flag,
#'     2 * 7,
#'     3 * 7
#'   )
#' }
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
