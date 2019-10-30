#' File Text Replacement
#'
#' Uses [base::gsub()] to perform text replacement on a file.
#'
#' @param file A string of the name of the file to modify.
#' @param pattern A string of the regular expression to match.
#' @param replacement A string of the replacement text.
#'
#' @return TRUE
#' @seealso [base::gsub()]
#' @export
gsub_file <- function(file, pattern, replacement) {
  chk_file(file)
  lines <- readLines(file)
  lines <- gsub(pattern = pattern, replacement = replacement, lines)
  writeLines(lines, file)
  invisible(TRUE)
}
