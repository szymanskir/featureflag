#' Function returning the class of an environment variable feature flag.
#'
#' @noRd
#'
.env_var_feature_flag_class <- function() {
  "env_var_feature_flag"
}

#' Creates an instance of a feature flag
#' that is enabled based on an environment variable
#'
#' @param env_var Name of the environment variable
#'
#' @export
#'
#' @return Feature flag that is enabled based on the specified environment variable
#'
#' @examples
#' {
#'   env_flag <- create_env_var_feature_flag(env_var = "FEATURE_X")
#' }
create_env_var_feature_flag <- function(env_var) {
  assert(
    is.character(env_var) && length(env_var) == 1,
    "'env_var' should be a single character string"
  )

  flag <- create_feature_flag()
  flag$env_var <- env_var

  prepend_class(flag, .env_var_feature_flag_class())
}

#' Checks if the given object is an instance of the
#' environment variable feature flag class.
#'
#' @param feature_flag Object to check whether it is an instance
#' of the environment variable feature flag class
#'
#' @return TRUE if the object is an instance of the environment variable feature
#' flag class.
#'
#' @noRd
#'
is_env_var_feature_flag <- function(feature_flag) {
  inherits(feature_flag, .env_var_feature_flag_class())
}

#' Checks if the given environment variable feature flag is enabled
#'
#' @param feature_flag Flag to be checked whether it is enabled
#'
#' @return TRUE if the environment variable is set to 'true'
#'
#' @export
#'
#' @examples
#' {
#'   flag <- create_env_var_feature_flag("FEATURE_X")
#'
#'   withr::with_envvar(new = list(FEATURE_X = "true"), {
#'     is_enabled(flag) # Returns TRUE
#'   })
#'
#'   is_enabled(flag) # Returns FALSE by default
#' }
is_enabled.env_var_feature_flag <- function(feature_flag) { # nolint
  stopifnot(is_env_var_feature_flag(feature_flag))

  env_value <- Sys.getenv(feature_flag$env_var, unset = NA)

  if (is.na(env_value)) {
    return(FALSE)
  }

  env_value_logical <- as.logical(env_value)
  if (is.na(env_value_logical)) {
    warning(
      sprintf(
        "value of env var '%s' could not be coerced to a logical",
        feature_flag$env_var
      )
    )
  }

  isTRUE(env_value_logical)
}
