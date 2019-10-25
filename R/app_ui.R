txt_input = function(..., width = '100%') shiny::textInput(..., width = width)

app_ui <- function() {
  miniUI::miniPage(title = "Batch file text replacement",
    miniUI::miniContentPanel(
      fillRow(
        shinyFiles::shinyDirButton("dir", "Find directory", "Upload", class = "btn-primary"),
        verbatimTextOutput("path", placeholder = TRUE),
        height = '60px', flex = c(1, 3)
      ),
      txt_input("pattern", "Pattern"),
      txt_input("replacement", "Replacement"),
      txt_input("regexp", "File Extension", value = "[.](R|r)$"),
      checkboxInput("recurse", "Recurse", value = FALSE)
    ),
    miniUI::gadgetTitleBar(NULL)
  )
}
