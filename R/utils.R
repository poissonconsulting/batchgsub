tibble <- function(...) {
  data <- data.frame(..., stringsAsFactors = FALSE)
  class(data) <- c("tbl_df", "tbl", "data.frame")
  data
}

is_try_error <- function(x) inherits(x, "try-error")

table_success <- function(x) {
  x <- tibble(x)
  x$File <- row.names(x)
  x$Success <- ifelse(x$x, "yes", "no")
  x[, c("File", "Success")]
}
