#' Greeting application outputs (UI)
#'
#' @description This is an example UI module function that displays the text
#' output that's been collected from `mod_greet_input_ui/server()`. It's been
#' adapted from the [`shinytest2` demo on YouTube](https://www.youtube.com/watch?v=Gucwz865aqQ)
#'
#' @param id namespace id
#'
#' @export mod_greet_output_ui
#'
#' @importFrom shiny NS tagList fluidRow column textOutput
#'
mod_greet_output_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::textOutput(ns("greeting")),
    shiny::textOutput(ns("first_letter"))
    )
}
#' Greeting application output (server)
#'
#' @description This is an example UI module function that displays the text
#' output that's been collected from `mod_greet_input_ui/server()`. It's been
#' adapted from the [`shinytest2` demo on YouTube](https://www.youtube.com/watch?v=Gucwz865aqQ)
#'
#'
#' @param id namespace'd id
#'
#' @export mod_greet_output_server
#'
#' @importFrom shiny moduleServer renderPrint reactive
#' @importFrom shiny renderText bindEvent
#'
mod_greet_output_server <- function(id, greeting) {
    shiny::moduleServer(id, function(input, output, session) {
    ns <- session

    first_letter <- shiny::reactive({
      greeting$first_letter()
    })

    output$greeting <- shiny::renderText({
      paste0("Hello ", input$name, "!")
    }) |>
      shiny::bindEvent({first_letter()})


    output$first_letter <- shiny::renderText({
        paste0("The first letter in your is ",
              first_letter(), "!")
      })

    })

}
