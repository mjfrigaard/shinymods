#' Print reactive values
#'
#' @param id namespace id
#'
#' @return code for UI and server components
#' @export prnt_rvals
#'
#' @importFrom rstudioapi insertText
#' @importFrom glue glue
#'
#' @examples
#' # prnt_rvals("dev")
prnt_rvals <- function(id) {
  ui <- "\n\n# put in UI ----
      bs4Dash::box(icon = shiny::icon('robot'),
        width = 12,
        title =
          shiny::tags$p(tags$code('{id}'),
            tags$code('values')),
        collapsible = TRUE,
        collapsed = TRUE,
        shiny::fluidRow(
          shiny::column(
            width = 12,
          shiny::verbatimTextOutput(
            outputId = shiny::NS(namespace = id, id = '{id}'))
          )
        )
      )"
  server <- "\n\n# put in server ----
    output${id} <- shiny::renderPrint({{
        vals <- shiny::reactiveValuesToList(
                  x = input, all.names = TRUE)
          print(vals)
        }})\n\n"
  rstudioapi::insertText(glue::glue(ui, server))
}
