#' Greeting application inputs (UI example function)
#'
#' @description This is an example UI module function that combines text input
#' and an action button to create a simple greeting app. It's been adapted from
#' the [`shinytest2` demo on YouTube](https://www.youtube.com/watch?v=Gucwz865aqQ)
#'
#'
#'
#' @param id namespace id
#'
#' @export mod_greet_input_ui
#'
#' @importFrom shiny NS tagList fluidRow column verbatimTextOutput
#'
mod_greet_input_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::textInput(ns("name"), "what is your name"),
    shiny::actionButton(ns("greet"), "Greet")
  )
}

#' Greeting application inputs (server)
#'
#' @description This is an example UI module function that combines text input
#' and an action button to create a simple greeting app. It's been adapted from
#' the [`shinytest2` demo on YouTube](https://www.youtube.com/watch?v=Gucwz865aqQ)
#'
#' @param id namespace'd id
#'
#' @export mod_greet_input_server
#'
#' @importFrom shiny moduleServer reactive renderPrint bindEvent
#' @importFrom stringr str_to_lower str_extract
#'
mod_greet_input_server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    ns <- session
    return(
      list(
      first_letter = shiny::reactive({
        shiny::req(input$name)
        stringr::str_to_lower(
          stringr::str_extract(input$name, "^.")
        )
      }) |>
        shiny::bindEvent({
          input$greet
        })
    ))
  })
}
