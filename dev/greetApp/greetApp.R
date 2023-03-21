greetApp <- function() {
  ui <- shiny::fluidPage(
    # put in UI ----
    mod_greet_input_ui("in"),
    # put in UI ----
    mod_greet_output_ui("out"),

    # put in UI ----
    shiny::fluidRow(
      shiny::column(
        width = 12,
        shiny::icon('user-astronaut'),
        shiny::verbatimTextOutput(
          outputId = 'vals'
        )
      )
    )
  )

  server <- function(input, output, session) {
    # put in server ----
    text <- mod_greet_input_server("in")
    # put in server ----
    mod_greet_output_server("out", text)
    # put in server ----
    output$vals <- shiny::renderPrint({
      vals <- shiny::reactiveValuesToList(
        x = input, all.names = TRUE
      )
      print(vals)
    })

  }

  shiny::shinyApp(ui = ui, server = server)
}
greetApp()
