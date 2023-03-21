library(shiny)

# put in UI ----
mod_import_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::icon('user-astronaut'),
      shiny::fileInput(
        inputId = ns('data'),
        label = 'Please upload a data file',
      # any file type
      accept = c(
        '.csv', '.tsv', '.txt',
        '.sas7bdat', '.dta', '.sav')
        )
    # << include additional input IDs >>
    )
}
# put in server ----
  mod_import_server <- function(id) {
    shiny::moduleServer(id, function(input, output, session) {
        ns <- session$ns
    # reactive imported data
    return(
      list(
        imported_data = shiny::reactive({
          shiny::req(input$data)
          uploaded <- import_flat_file(path = input$data$datapath)
          return(uploaded)
          })
      )
    )
    })
  }
# display for UI ----
mod_prnt_data_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::code("mod = TRUE, return = TRUE"),
    shiny::verbatimTextOutput(ns("out"), placeholder = TRUE)
  )
}
# put in server ----
mod_prnt_data_server <- function(id, imported_flat_data) {
  shiny::moduleServer(id, function(input, output, session) {
    ns <- session$ns
    shiny::observe({
      output$out <- shiny::renderPrint({
        imported_flat_data$imported_data()
      })
    }) |> shiny::bindEvent(imported_flat_data$imported_data())
  })
}

getDataDemo <- function() {
  ui <- shiny::fluidPage(
    # put in UI ----
    mod_import_ui("return"),
    # put in UI ----
    mod_prnt_data_ui('print'),
    # put in UI ----
    shiny::tagList(
      shiny::code("mod = FALSE, return = TRUE or FALSE"),
      shiny::icon('user-astronaut'),
        shiny::fileInput(
          inputId = 'data',
          label = 'Please upload a data file',
        # any file type
        accept = c(
          '.csv', '.tsv', '.txt',
          '.sas7bdat', '.dta', '.sav')
          ),
      shiny::verbatimTextOutput("out", placeholder = TRUE)
    )
  )

  server <- function(input, output, session) {

    # put in server ----
    # returned data
    data <- mod_import_server(id = "return")

    # put in server ----
    mod_prnt_data_server(id = 'print', imported_flat_data = data)

    # put in server ----
    # reactive imported data
    imported_data = shiny::reactive({
      shiny::req(input$data)
      uploaded <- import_flat_file(path = input$data$datapath)
      return(uploaded)
      })

    output$out <- shiny::renderPrint({
      imported_data()
    })



  }

  shiny::shinyApp(ui, server)
}
getDataDemo()
