app_server <- function(input, output, session) {
  
  clear_inputs <- function() {
    updateTextInput(session, "pattern", value = "")
    updateTextInput(session, "replacement", value = "")
    updateCheckboxInput(session, "recurse", value = FALSE)
    updateTextInput(session, "regexp", value = "[.](R|r)$")
    global$ready <- FALSE
    global$datapath <- NULL
  }
  
  show_success <- function(x) {
    x <- data.frame(x)
    x$File <- row.names(x)
    x$Success <- ifelse(x$x, "yes", "no")
    x[, c("File", "Success")]
  }
  
  cleanup <- function(path, recurse){
    batchr::batch_cleanup(path = path, force = TRUE, recursive = recurse)
  }
  
  modal_none <- function(){
    modal_none <- modalDialog(h5("There are no files matching that extension"),
                              footer = modalButton("Got it"))
  }
  
  modal_some <- function(remaining){
    modalDialog(h5(paste(length(remaining), "files will be modified")),
                p(paste(remaining, collapse = ", ")),
                br(), br(),
                button("yes_modify", "Go for it"),
                button("no_modify", "Abort"),
                footer = NULL)
  }
  
  modal_clean <- function(){
    modalDialog(
      h5("That directory already has a configuration file. 
         Would you like to remove it before proceeding?"),
      br(), br(),
      button("yes_clean", "Yes"),
      button("no_clean", "No"), 
      footer = NULL
    )
  } 

  shinyFiles::shinyDirChoose(input, "dir", roots = c(home = "~"))

  global <- reactiveValues(datapath = NULL,
                           ready = FALSE)

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
    req(global$datapath)
    path <- global$datapath
    
    clean <- batchr::batch_is_clean(path, recurse = input$recurse)

    if(!clean){
      return(showModal(modal_clean()))
    } else {
      global$ready <- TRUE
    }
  })
  
  observe({
    if(!global$ready) 
      return()
    
    path <- global$datapath
    remaining <- try(batchr::batch_config(batchr::gsub_file, pattern = input$pattern,
                                          replacement = input$replacement, path = path,
                                          regexp = input$regexp, recurse = input$recurse), silent = TRUE)

      if(inherits(remaining, "try-error")){
        global$ready <- FALSE
        return(showModal(modal_none()))
      }
      showModal(modal_some(remaining))
    })
  
  observeEvent(input$no_clean, {
    global$ready <- FALSE
    removeModal(session)
  })
  
  observeEvent(input$no_modify, {
    global$ready <- FALSE
    cleanup(global$datapath, input$recurse)
    removeModal(session)
  })
  
  observeEvent(input$yes_modify, {
    path <- global$datapath
    success <- batchr::batch_run(
      path = path, ask = FALSE, progress = FALSE
    )
    cleanup(path, input$recurse)
    removeModal(session)
    showModal(modalDialog(h5(paste(sum(success), "files successfully modified")),
                          tableOutput("success"),
                          footer = modalButton("Got it")))
    output$success <- renderTable(show_success(success))
    clear_inputs()
  })
  
  observeEvent(input$yes_clean, {
    cleanup(global$datapath, input$recurse)
    global$ready <- TRUE
    removeModal(session)
  })
}
