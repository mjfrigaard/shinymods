#' Example print reactive values UI function
#'
#' @param id
#'
#' @description This is an example of the `prnt_reactvals()` function.
#'
#' @details
#' ## Function arguments
#'
#' The following arguments were used to generate this module:
#'
#' ```
#' prnt_reactvals(name = "vals", id = "dev", mod = TRUE)
#' ```
#'
#' @export mod_vals_ui
#'
#' @importFrom shiny NS tagList textInput icon verbatimTextOutput
#'
mod_vals_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    # << include additional input IDs >>
    shiny::textInput(ns("txt"), label = "Text input"),
    shiny::icon("user-astronaut"),
    shiny::verbatimTextOutput(
      outputId = ns("dev")
    )
  )
}

#' Example print reactive values server function
#'
#' @description This is an example of the `prnt_reactvals()` function.
#'
#' @details
#' ## Function arguments
#'
#' The following arguments were used to generate this module:
#'
#' ```
#' prnt_reactvals(name = "vals", id = "dev", mod = TRUE)
#' ```
#'
#' @export mod_vals_server
#'
#' @importFrom shiny moduleServer renderPrint reactiveValuesToList
#'
# put in server ----
mod_vals_server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    ns <- session$ns

    output$dev <- shiny::renderPrint({
      vals <- shiny::reactiveValuesToList(
        x = input, all.names = TRUE
      )
      print(vals)
    })
  })
}

#' Example print reactive values application
#'
#' @description This is an application using the `prnt_reactvals()` function.
#'
#' @details
#' ## App structure
#'
#' The UI and server contains *both* outputs from the `prnt_reactvals()` function:
#'
#' ```
#' prnt_reactvals(name = "vals", id = "dev", mod = TRUE)
#' ```
#'
#' *and*
#'
#' ```
#' prnt_reactvals(name = "vals", id = "dev", mod = FALSE)
#' ```
#'
#' @export reactValsDemo
#'
#' @importFrom shiny fluidPage tagList
#' @importFrom shiny tags icon verbatimTextOutput
#' @importFrom shiny renderPrint reactiveValuesToList shinyApp
#'
#' @examplesIf interactive()
#' reactValsDemo()
reactValsDemo <- function() {
  ui <- shiny::fluidPage(
    # put in UI ----
    mod_vals_ui("x"),
    # put in UI ----
    shiny::tagList(
      shiny::tags$code("vals"),
      shiny::icon("user-astronaut"),
      shiny::verbatimTextOutput(
        outputId = "dev"
      )
    )
  )

  server <- function(input, output, session) {
    # put in server ----
    mod_vals_server("x")
    # put in server ----
    output$dev <- shiny::renderPrint({
      vals <- shiny::reactiveValuesToList(
        x = input, all.names = TRUE
      )
      print(vals)
    })
  }

  shiny::shinyApp(ui, server)
}
