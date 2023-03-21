#' Create a 'print reactive values' module
#'
#' @param name name of the module
#' @param id namespace id
#'
#' @return code for UI and server components
#' @export prnt_reactvals
#'
#' @importFrom rstudioapi insertText
#' @importFrom glue glue
#'
#' @examplesIf interactive()
#' prnt_reactvals(name = "vals", id = "dev", mod = TRUE)
prnt_reactvals <- function(name, id, mod = TRUE) {
  if (isTRUE(mod)) {
  ui <- glue::glue("\n\n# put in UI ----
  mod_{name}_ui <- function(id) {{
    ns <- shiny::NS(id)
    shiny::tagList(
    # << include additional input IDs >>
      shiny::icon('user-astronaut'),
        shiny::verbatimTextOutput(
          outputId = ns('{id}')
      )
  )
}}")
  server <- glue::glue("\n\n# put in server ----
  mod_{name}_server <- function(id) {{

    shiny::moduleServer(id, function(input, output, session) {{
        ns <- session$ns

        output${id} <- shiny::renderPrint({{
          vals <- shiny::reactiveValuesToList(
            x = input, all.names = TRUE
          )
          print(vals)
      }})
    }})
  }}
  \n\n"
    )
  } else {
    ui <- glue::glue("\n\n# put in UI ----
  shiny::tagList(
    shiny::tags$code('{name}'),
      shiny::icon('user-astronaut'),
        shiny::verbatimTextOutput(
          outputId = '{id}'
        )
  )")
  server <- glue::glue("\n\n# put in server ----
  output${id} <- shiny::renderPrint({{
    vals <- shiny::reactiveValuesToList(
      x = input, all.names = TRUE
    )
    print(vals)
  }})\n\n"
      )
  }
  rstudioapi::insertText(paste0(ui, "\n", server))
}
