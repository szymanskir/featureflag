
<!-- README.md is generated from README.Rmd. Please edit that file -->

# featureflag

<!-- badges: start -->

[![R build
status](https://github.com/szymanskir/featureflag/workflows/R-CMD-check/badge.svg)](https://github.com/szymanskir/featureflag/actions)
<!-- badges: end -->

The `featureflag` package provides a feature flag (also called as
feature toggles, feature switches) implementation for R. Feature flags
allow developers to turn functionalities on and off based on
configuration.

If you are interested in learning more about feature flags, check out
those great resources:

  - <https://martinfowler.com/articles/feature-toggles.html>
  - <https://featureflags.io/>
  - <https://en.wikipedia.org/wiki/Feature_toggle>

## Installation

Install the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("szymanskir/featureflag")
```

## Examples

### Simple example

The `featureflag` package currently supports one type of feature flags:
bool feature flags (simple on and off flags):

``` r
library(featureflag)

my_feature_flag <- create_bool_feature_flag(TRUE)

if (is_enabled(my_feature_flag)) {
  print("My feature is enabled!")
} else {
  print("My feature is not enabled!")
}
```

### if and if/else helpers

`featureflag` provides helpers that allow you to omit boilerplate code
such as `if` or `if/else`. They can be replace by the usage of
`feature_if` or `feature_ifelse` accordingly:

``` r
feature_ifelse(
  my_feature_flag,
  print("My feature is enabled!"),
  print("My feature is not enabled!")
)
```

### Shiny example

The source code of all examples is available in the [examples
folder](./examples) of the repository.

Feature flags can be especially useful when developing shiny
applications. The example below shows how feature flags can be used to
turn parts application on and off – in this case an extra instance of
the counter module.

``` r
FLAGS <- list(
    extra_counter_flag = create_bool_feature_flag(value = FALSE)
)


ui <- fluidPage(
    counterButton("counter1", "Always Visible Counter"),

    feature_if(FLAGS$extra_counter_flag, {
        counterButton("flagged_counter", "Flagged Counter")
    })
)

server <- function(input, output, session) {
    counterServer("counter1")

    feature_if(FLAGS$extra_counter_flag, {
        counterServer("flagged_counter")
    })
}
```

### Defining feature flags in configuration files

The `featureflag` package can also be used in combination with the
[config](https://cran.r-project.org/web/packages/config/index.html)
package by using the R code execution feature:

``` yml
default:
  extra_counter_flag: !expr featureflag::create_bool_feature_flag(value = TRUE)

test:
  extra_counter_flag: !expr featureflag::create_bool_feature_flag(value = TRUE)

production:
  extra_counter_flag: !expr featureflag::create_bool_feature_flag(value = FALSE)
```

## Create your own feature flag

You can create feature flags that are turned on based on your own custom
criteria. The procedure on how to define your own feature flag is
presented in [this tutorial](./docs/define-custom-feature-flags.md)
