app_server <- function(input, output, session) {
  
  shinyFiles::shinyDirChoose(
    input,
    'dir',
    roots = c(home = '~')
  )
  
  global <- reactiveValues(datapath = getwd())
  
  output$path <- renderText({
    global$datapath
  })
  
  observeEvent(input$dir, {
    if (!"path" %in% names(input$dir)) return()
    home <- normalizePath("~")
    global$datapath <-
      file.path(home, paste(unlist(input$dir$path[-1]), 
                            collapse = .Platform$file.sep))
  })
  
  observeEvent(input$go, {
    withProgress(batchr::batch_gsub(pattern = input$pattern, replacement = input$replacement,
                                    path = global$datapath, regexp = input$regexp,
                                    recurse = input$recurse, progress = FALSE, report = FALSE, 
                                    ask = FALSE), value = 0.5, 
                 message = "completing task...")
    updateTextInput(session, "pattern", value = "")
    updateTextInput(session, "replacement", value = "")
    
    showModal(modalDialog(h5("Task complete"), footer = modalButton("Got it")))
    
  })
  
}
