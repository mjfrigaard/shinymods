#' Get flat data file module
#'
#' @param name name of the module
#' @param id namespace id
#' @param mod logical, as module?
#' @param return_data logical, return the flat file data in a reactive list?
#'
#' @return code for UI and server components
#' @export get_flat_data
#'
#' @importFrom rstudioapi insertText
#' @importFrom glue glue
#'
#' @examplesIf interactive()
#' # return data import (module)
#' get_flat_data(name = "import", id = "data", mod = TRUE, return_data = TRUE)
#' # return data import (UI and server code)
#' get_flat_data(name = "import", id = "data", mod = FALSE, return_data = TRUE)
#' # do not return data import (module)
#' get_flat_data(name = "import", id = "data", mod = TRUE, return_data = FALSE)
#' # do not return data import (UI and server code)
#' get_flat_data(name = "import", id = "data", mod = FALSE, return_data = FALSE)
get_flat_data <- function(name, id, mod = TRUE, return_data = TRUE) {
  if (isTRUE(mod) & isTRUE(return_data)) {
  ui <- glue::glue("\n
# put in UI ----
mod_{name}_ui <- function(id) {{
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::icon('user-astronaut'),
      shiny::fileInput(
        inputId = ns('{id}'),
        label = 'Please upload a data file',
      # any file type
      accept = c(
        '.csv', '.tsv', '.txt',
        '.sas7bdat', '.dta', '.sav')
        )
    # << include additional input IDs >>
    )
}}")
  server <- glue::glue("\n\n# put in server ----
  mod_{name}_server <- function(id) {{
    shiny::moduleServer(id, function(input, output, session) {{
        ns <- session$ns
    # return imported data as reactive
    return(
      list(
        imported_data = shiny::reactive({{
          shiny::req(input${id})
          uploaded <- import_flat_file(path = input${id}$datapath)
          return(uploaded)
          }})
      )
    )
    }})
  }}
  \n\n"
    )
  } else if (isTRUE(mod) & isFALSE(return_data)) {
  ui <- glue::glue("\n
# put in UI ----
mod_{name}_ui <- function(id) {{
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::icon('user-astronaut'),
      shiny::fileInput(
        inputId = ns('{id}'),
        label = 'Please upload a data file',
      # any file type
      accept = c(
        '.csv', '.tsv', '.txt',
        '.sas7bdat', '.dta', '.sav')
        )
    # << include additional input IDs >>
    )
}}")
  server <- glue::glue("\n\n# put in server ----
  mod_{name}_server <- function(id) {{
    shiny::moduleServer(id, function(input, output, session) {{
        ns <- session$ns
    # data as reactive available in module as imported_data()
        imported_data = shiny::reactive({{
          shiny::req(input${id})
          uploaded <- import_flat_file(path = input${id}$datapath)
          return(uploaded)
          }})
    }})
  }}
  \n\n"
    )
} else if (isFALSE(mod) & isTRUE(return_data)) {
    ui <- glue::glue("\n\n# put in UI ----
  shiny::tagList(
    shiny::tags$code('{name}'),
    shiny::icon('user-astronaut'),
      shiny::fileInput(
        inputId = '{id}',
        label = 'Please upload a data file',
      # any file type
      accept = c(
        '.csv', '.tsv', '.txt',
        '.sas7bdat', '.dta', '.sav')
        )
      # << include additional input IDs >>
  )")
  server <- glue::glue("\n
    # put in server ----
    # data as reactive available as imported_data()
        imported_data = shiny::reactive({{
          shiny::req(input${id})
          uploaded <- import_data(path = input${id}$datapath)
          return(uploaded)
          }})
    \n"
    )
} else {
    ui <- glue::glue("\n\n# put in UI ----
  shiny::tagList(
    shiny::tags$code('{name}'),
    shiny::icon('user-astronaut'),
      shiny::fileInput(
        inputId = '{id}',
        label = 'Please upload a data file',
      # any file type
      accept = c(
        '.csv', '.tsv', '.txt',
        '.sas7bdat', '.dta', '.sav')
        )
      # << include additional input IDs >>
  )")
  server <- glue::glue("\n
    # put in server ----
    # data as reactive available as imported_data()
        imported_data = shiny::reactive({{
          shiny::req(input${id})
          uploaded <- import_data(path = input${id}$datapath)
          return(uploaded)
          }})
    \n"
    )
  }
  rstudioapi::insertText(paste0(ui, "\n", server))
}
