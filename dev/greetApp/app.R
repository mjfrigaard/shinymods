library(shiny)
library(stringr)

ui <- shiny::fluidPage(
  shiny::textInput("name", "what is your name"),
  shiny::actionButton("greet", "Greet"),
  shiny::textOutput("greeting"),
  shiny::textOutput("first_letter")
)

server <- function(input, output, session) {
  output$greeting <- shiny::renderText({
    shiny::req(input$name)
    paste0("Hello ", input$name, "!")
  }) |>
    bindEvent({
      input$greet
    })

  first_letter <- shiny::reactive({
    shiny::req(input$name)
    stringr::str_to_lower(
      stringr::str_extract(input$name, "^.")
    )
  }) |>
    shiny::bindEvent({
      input$greet
    })

  output$first_letter <- shiny::renderText({
    paste0(
      "The first letter in your is ",
      first_letter(), "!"
    )
  })
}

shiny::shinyApp(ui, server)
