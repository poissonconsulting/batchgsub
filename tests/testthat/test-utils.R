context("internal-utils")

test_that("is_try_error", {
  expect_false(is_try_error(1))
  expect_false(is_try_error(identity(1)))
  expect_true(is_try_error(try(stop(), silent = TRUE)))
})

test_that("tibble", {
  expect_identical(
    tibble(data.frame()),
    structure(list(), .Names = character(0), class = c(
      "tbl_df",
      "tbl", "data.frame"
    ), row.names = integer(0))
  )

  expect_identical(
    tibble(data.frame(x = 1)),
    structure(list(x = 1), class = c("tbl_df", "tbl", "data.frame"), row.names = c(NA, -1L))
  )

  expect_identical(
    tibble(x = 1),
    structure(list(x = 1), class = c("tbl_df", "tbl", "data.frame"), row.names = c(NA, -1L))
  )

  expect_identical(
    tibble(x = "1"),
    structure(list(x = "1"), class = c("tbl_df", "tbl", "data.frame"), row.names = c(NA, -1L))
  )
})
