#' File Text Replacement
#'
#' Uses [base::gsub()] to perform text replacement on a file.
#'
#' @param file A string of the name of the file to modify.
#' @param pattern A string of the regular expression to match.
#' @param replacement A string of the replacement text.
#' @param ignore.case A flag specifying whether to ignore the case.
#' @param fixed A flag specifying whether to match `pattern` as is 
#' (as opposed to as a regular expression).
#'
#' @return TRUE
#' @seealso [base::gsub()]
#' @export
gsub_file <- function(file, pattern, replacement, ignore.case = FALSE, fixed = FALSE) {
  chk_file(file)
  lines <- readLines(file)
  lines <- gsub(pattern = pattern, replacement = replacement, lines,
                ignore.case = ignore.case, fixed = fixed)
  writeLines(lines, file)
  invisible(TRUE)
}
