#' Run the batch_gsub Shiny Application
#'
#' @param path A character string of the default path.
#' @export
run_app <- function(path = getwd()) {
  chk::chk_string(path)
  shinyOptions(path = path)
  shiny::runGadget(app = shiny::shinyAppDir(system.file("app", package = "batchgsub")),
    viewer = shiny::dialogViewer("Batch file text replacement", height = 400))
}
