#' Run the batch_gsub Shiny Application
#'
#' @export
run_app <- function() {
  shiny::runGadget(app = shiny::shinyAppDir(system.file("app", package = "batchgsub")),
    stopOnCancel = FALSE,
    viewer = shiny::dialogViewer("Batch file text replacement", height = 400))
}
