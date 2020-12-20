# Introduction

In this document types of feature flags that are considered to be implemented in the package are described. Each section corresponds to a type of feature flag along with its possible usages and difficulties in implementing them.

## Boolean flags

* Yes/No type of flag
* Simple to implement

## Period flags

* feature is enabled from/to
* 3 variants:
  * available from
  * available to
  * available from to
  
## Percentage flags

* feature is enabled with a given probability
* nice usage for A/B testing
* difficulties in regards of providing the same results for users

## Rollout Percentage flag

* Similar to the percentage flag, but with an increasing percentage with time
* Not sure if appropriate to handle rollout on the application level (on the platform level it might be easier)

## Role based flags

* feature is enabled for specific user roles
* More research needed in terms of using roles/groups in R apps
