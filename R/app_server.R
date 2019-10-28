app_server <- function(input, output, session) {

  clear_inputs <- function() {
    updateTextInput(session, "pattern", value = "")
    updateTextInput(session, "replacement", value = "")
    updateCheckboxInput(session, "recurse", value = FALSE)
    updateTextInput(session, "regexp", value = "[.](R|r)$")
    global$datapath <- NULL
  }

  show_success <- function(x) {
    x <- data.frame(x)
    x$File <- row.names(x)
    x$Success <- ifelse(x$x, "yes", "no")
    x[, c("File", "Success")]
  }

  shinyFiles::shinyDirChoose(input, "dir", roots = c(home = "~"))

  global <- reactiveValues(datapath = NULL)

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
    batchr::batch_cleanup(path)
    remaining <- try(batchr::batch_config(batchr::gsub_file, pattern = input$pattern,
      replacement = input$replacement, path = path,
      regexp = input$regexp, recurse = input$recurse), silent = TRUE)

    modal_none <- modalDialog(h5("There are no files matching that extension"),
      footer = modalButton("Got it"))

    modal_some <- modalDialog(h5(paste(length(remaining), "files will be modified")),
      p(paste(remaining, collapse = ", ")),
      br(), br(),
      button("yes", "Go for it"),
      button("no", "Abort"),
      footer = NULL)

    if(inherits(remaining, "try-error"))
      return(showModal(modal_none))
    showModal(modal_some)
  })

  observeEvent(input$no, {
    clear_inputs()
    removeModal(session)
  })

  observeEvent(input$yes, {
    path <- global$datapath
    success <- batchr::batch_run(
      path = path, ask = FALSE, progress = FALSE
    )
    batchr::batch_cleanup(path, force = FALSE)
    removeModal(session)
    showModal(modalDialog(h5(paste(sum(success), "files successfully modified")),
      tableOutput("success"),
      footer = modalButton("Got it")))
    output$success <- renderTable(show_success(success))
    clear_inputs()
  })

}
