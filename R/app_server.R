app_server <- function(input, output, session) {
  
  shinyFiles::shinyDirChoose(input, 'dir', roots = c(home = '~'))
  
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
  
  observeEvent(input$done, {
    path <- global$datapath
    if (length(batchr:::config_files(path, recursive = FALSE))) {
      batchr::batch_reconfig_fun(batchr::gsub_file, pattern = input$pattern,
                                 replacement = input$replacement, path = path)
    } else {
      batchr::batch_config(batchr::gsub_file, pattern = input$pattern,
                           replacement = input$replacement, path = path,
                           regexp = input$regexp, recurse = input$recurse)
    }

    remaining <- batchr::batch_files_remaining(path)
    
    modal <- modalDialog(h5(paste(length(remaining), "files will be modified")),
                p(paste(remaining, collapse = ", ")),
                footer = modalButton("Go for it"))
    
    showModal(modal)
    
    
    
    # withProgress(batchr::batch_gsub(pattern = input$pattern, replacement = input$replacement,
    #                                 path = global$datapath, regexp = input$regexp,
    #                                 recurse = input$recurse, progress = FALSE, report = FALSE, 
    #                                 ask = FALSE), value = 0.5, 
    #              message = "completing task...")
    # updateTextInput(session, "pattern", value = "")
    # updateTextInput(session, "replacement", value = "")
    
  })
  
  shiny::observeEvent(input$cancel, {
    shiny::stopApp()
  })
  
}
