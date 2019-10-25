app_ui <- function() {
  miniUI::miniPage(
    miniUI::gadgetTitleBar("batch_gsub", 
                           right = actionButton("go", "Go!", class = "btn-primary")),
    miniUI::miniContentPanel(
      shinyFiles::shinyDirButton("dir", "Find directory", "Upload", class = "btn-primary"),
      verbatimTextOutput("path", placeholder = TRUE),
      textInput("pattern", "Pattern"),
      textInput("replacement", "Replacement"),
      textInput("regexp", "Regexp", value = "[.](R|r)$"),
      checkboxInput("recurse", "Recurse", value = FALSE)
    )
  )
}
