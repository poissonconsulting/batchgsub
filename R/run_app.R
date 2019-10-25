#' Run the batch_gsub Shiny Application
#'
#' @export
run_app <- function() {
  shiny::runGadget(app = shiny::shinyAppDir(system.file("app", package = "batchr")))
}
