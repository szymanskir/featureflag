# Introduction

In this document the process of implementing custom feature flags is presented. In the subsequent sections we will create a feature flag that is enabled if it's `number` field is odd.


## Functions to be implemented
Each feature flag requires 1 function to be implemented:

* `is_enabled.<FEATURE_FLAG>` - S3 method computing whether the feature flag is enabled

However, it is recommended to additionally include:

* `create_<YOUR_FEATURE_FLAG>_feature_flag` - function that creates an instance of your feature flag (note: this function can be called however you want, this is just a suggestion)

* `is_<YOUR_FEATURE_FLAG_NAME>` - function that returns TRUE if the passed object is an instance of the feature flag class (that we are currently defining)

## Create feature flag function
Let's start with a construction method that will use create a base feature flag, add the `number` field to it and assign it to the proper class.

```r
create_odd_feature_flag <- function(number) {
  flag <- create_feature_flag()
  
  flag$number <- number
  class(flag) <- c("odd_feature_flag", class(flag))
  
  flag
}
```

## Class checking function
Next, we will create a function checking the class attribute of the object.

```r
is_odd_feature_flag <- function(feature_flag) {
  inherits(feature_flag, "odd_feature_flag")
}
```

## is_enabled function
Finally, we define the `is_enabled` function which checks whether the `number` field of our flag is odd.

```r
is_enabled.odd_feature_flag <- function(feature_flag) {
  stopifnot(is_odd_feature_flag(feature_flag))
  (feature_flag$number %% 2) != 0
}
```
