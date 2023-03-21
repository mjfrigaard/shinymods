#' Example get imported flat file data UI function
#'
#' @param id
#'
#' @description This is an example UI function from `get_flat_data()`
#'
#' @details
#' ## Function arguments
#'
#' The following arguments were used to generate `mod_import_ui/server()`:
#'
#' ```
#' get_flat_data(name = "import", id = "data", mod = TRUE, return_data = TRUE)
#' ```
#'
#'
#' @export mod_import_ui
#'
#' @importFrom shiny NS tagList icon
#' @importFrom shiny fileInput tagList icon
#'
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
#' Example get imported flat file data server function
#'
#' @param id
#'
#' @description This is an example server function from `get_flat_data()`
#'
#' @details
#' ## Function arguments
#'
#' The following arguments were used to generate `mod_import_ui/server()`:
#'
#' ```
#' get_flat_data(name = "import", id = "data", mod = TRUE, return_data = TRUE)
#' ```
#'
#' ## Return
#'
#' `return_data = TRUE` will return the imported data as a reactive list.
#'
#'
#' @export mod_import_ui
#'
#' @importFrom shiny moduleServer reactive req
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
#' Print the returned values from `get_flat_data()` (UI)
#'
#' @param id
#'
#' @description This module is used in `getDataDemo()` to demonstrate how to
#' display the returned values from `get_flat_data()`.
#'
#' @importFrom shiny NS code verbatimTextOutput
mod_prnt_data_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::code("mod = TRUE, return = TRUE"),
    shiny::verbatimTextOutput(ns("out"), placeholder = TRUE)
  )
}
#' Print the returned values from `get_flat_data()` (server)
#'
#' @param id
#'
#' @description This module is used in `getDataDemo()` to demonstrate how to
#' display the returned values from `get_flat_data()`.
#'
#' @importFrom shiny moduleServer renderPrint bindEvent
#'
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

#' Example get imported data application
#'
#' @description This is an application using the `get_flat_data()` function.
#'
#' @details
#' ## App structure
#'
#' The UI and server contains examples from the following `get_flat_data()`
#' function arguments:
#'
#' ```
#' get_flat_data(name = 'import', id = 'data', mod = TRUE, return_data = TRUE)
#' ```
#'
#' *and*
#'
#' ```
#' get_flat_data(name = 'import', id = 'data', mod = FALSE, return_data = FALSE)
#' ```
#'
#' ## Module function arguments
#'
#' If `mod` and `return_data` are set to `TRUE`, then the module will not
#' display the imported data. To verify the data have been imported,
#' `getDataDemo()` has an additional module (`mod_prnt_data_ui()/server()`) that
#' renders the imported data via `shiny::verbatimTextOutput()` and
#' `shiny::renderPrint()`.
#'
#' ## UI/server arguments
#'
#' If `mod` is set to `FALSE`, `get_flat_data()` returns UI and server code for
#' importing data and returning a reactive object (`imported_data()`).
#' `getDataDemo()` also displays these data using `shiny::verbatimTextOutput()`
#' and `shiny::renderPrint()`
#'
#'
#' @export getDataDemo
#'
#' @importFrom shiny fluidPage tagList tags icon code fileInput
#' @importFrom shiny reactive renderPrint verbatimTextOutput
#' @importFrom shiny req reactiveValuesToList shinyApp
#'
#' @examplesIf interactive()
#' getDataDemo()
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
