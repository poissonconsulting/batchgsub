#' Batch File Text Replacement
#'
#' Uses [batchr::batch_process()] and [gsub_file()] to
#' perform batch text file replacement.
#' By default it replaces text in all .R and .r files in the working directory.
#'
#' @inheritParams batchr::batch_config
#' @inheritParams batchr::batch_run
#' @inheritParams batchr::batch_cleanup
#' @inheritParams batchr::batch_process
#' @inheritParams gsub_file
#'
#' @seealso [batchr::batch_process()] and [gsub_file()]
#' @return An invisible flag indicating whether all the files were
#' successfully processed.
#' @export
batch_gsub <- function(pattern, replacement,
                       path, regexp = "[.](R|r)$", recurse = FALSE,
                       progress = FALSE, report = TRUE,
                       options = furrr::future_options(),
                       ask = getOption("batchr.ask", TRUE)) {
  batchr::batch_process(gsub_file,
    pattern = pattern, replacement = replacement, report = report,
    path = path, regexp = regexp, recurse = recurse,
    progress = progress, options = options, ask = ask
  )
}
