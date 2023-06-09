% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_flat_data.R
\name{get_flat_data}
\alias{get_flat_data}
\title{Get flat data file module}
\usage{
get_flat_data(name, id, mod = TRUE, return_data = TRUE)
}
\arguments{
\item{name}{name of the module}

\item{id}{namespace id}

\item{mod}{logical, as module?}

\item{return_data}{logical, return the flat file data in a reactive list?}
}
\value{
code for UI and server components
}
\description{
Get flat data file module
}
\examples{
# return data import (module)
get_flat_data(name = "import", id = "data", mod = TRUE, return_data = TRUE)
# return data import (UI and server code)
get_flat_data(name = "import", id = "data", mod = FALSE, return_data = TRUE)
# do not return data import (module)
get_flat_data(name = "import", id = "data", mod = TRUE, return_data = FALSE)
# do not return data import (UI and server code)
get_flat_data(name = "import", id = "data", mod = FALSE, return_data = FALSE)
}
