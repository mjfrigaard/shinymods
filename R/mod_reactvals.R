#' Print reactive values (UI)
#'
#' @param id namespace id
#'
#' @export mod_reactvals_ui
#'
#' @importFrom shiny NS tagList fluidRow column verbatimTextOutput
#'
mod_reactvals_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::fluidRow(
      shiny::column(
        width = 6,
        shiny::textInput(ns('txt'),
          label = 'text')
        ),
      shiny::column(
        width = 6,
        shiny::verbatimTextOutput(
          outputId = ns('vals')
        )
    )
  )
  )
}
#' Print reactive values (server)
#'
#' @param id namespace'd id
#'
#' @export mod_reactvals_server
#'
#' @importFrom shiny moduleServer renderPrint
#'
mod_reactvals_server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    ns <- session$ns
    output$vals <- shiny::renderPrint({
      vals <- shiny::reactiveValuesToList(
        x = input, all.names = TRUE
      )
      print(vals)
    })
  })
}
