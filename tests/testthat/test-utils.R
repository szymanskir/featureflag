test_that("null or datetime check asserts correctly null values", {
  expect_true(null_or_datetime(NULL))
})

test_that("null or datetime check asserts correctly datetime values", {
  expect_true(null_or_datetime(ISOdatetime(2020, 10, 1, 1, 0, 0, tz = "UTC")))
})

test_that("null or datetime check asserts correctly date values", {
  expect_false(null_or_datetime(as.Date("2010-1-1")))
})

test_that("null or datetime check asserts correctly NA datetime values", {
  expect_false(null_or_datetime(ISOdatetime(2020, 0, 0, 0, 0, 0, tz = "UTC")))
})
