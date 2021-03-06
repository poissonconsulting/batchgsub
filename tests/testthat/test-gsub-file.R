context("gsub-file")

test_that("gsub_file", {
  teardown(unlink(file.path(tempdir(), "batchr")))

  path <- file.path(tempdir(), "batchr")
  unlink(path, recursive = TRUE)
  dir.create(path)
  file <- file.path(path, "file.r")
  lines <- c("some zz", "and some more zzzz zzz zz Z", "a dot.")
  writeLines(lines, file)
  expect_identical(readLines(file), lines)
  expect_true(gsub_file(file, ".", " or two.", fixed = TRUE))
  lines <- c("some zz", "and some more zzzz zzz zz Z", "a dot or two.")
  expect_identical(readLines(file), lines)
  expect_true(gsub_file(file, "Z", "aa"))
  lines <- c("some zz", "and some more zzzz zzz zz aa", "a dot or two.")
  expect_identical(readLines(file), lines)
  expect_true(gsub_file(file, "zz", "b"))
  lines <- c("some b", "and some more bb bz b aa", "a dot or two.")
  expect_identical(readLines(file), lines)
})
