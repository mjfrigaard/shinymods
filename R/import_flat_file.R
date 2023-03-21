#' Import flat data files
#'
#' @param path path to data file (with extension)
#'
#' @description Imports a variety of flat file types (SAS, SPSS, Stata, and
#'     plain text files).
#'
#' @return return_data as loaded flat file
#'
#' @export import_flat_file
#'
#' @importFrom vroom vroom
#' @importFrom haven read_sas read_sav read_dta
#' @importFrom tools file_ext
#' @importFrom tibble as_tibble
import_flat_file <- function(path) {
  ext <- tools::file_ext(path)
  data <- switch(ext,
    txt = vroom::vroom(path),
    csv = vroom::vroom(path, delim = ","),
    tsv = vroom::vroom(path, delim = "\t"),
    sas7bdat = haven::read_sas(data_file = path),
    sas7bcat = haven::read_sas(data_file = path),
    sav = haven::read_sav(file = path),
    dta = haven::read_dta(file = path)
  )
  # return a tibble
  return_data <- tibble::as_tibble(data)
  return(return_data)
}
