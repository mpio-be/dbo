utils::globalVariables(
  c(
    ".pk",
    ".duplicates",
    "scinam_tdata",
    "scinam_ttax",
    "db",
    "N",
    "geometry"
  )
)
NULL


   
#' \strong{d}ata \strong{b}ase interface for scidb.\strong{o}rn.mpg.de
#'
#' An interface to \href{http://scidb.mpio.orn.mpg.de}{scidb.mpio.orn.mpg.de} databases
#'
#'
#' @docType package
#' @name dbo
"_PACKAGE"
#'
#' @author Mihai Valcu \email{valcu@@orn.mpg.de}
#'
#' @import     methods utils data.table
#' @import     RMariaDB DBI
#' @importFrom stringr str_trim str_detect str_replace str_glue str_split regex
#' @importFrom glue glue
#' @importFrom rappdirs user_config_dir
#' @importFrom stats rnorm rpois runif
#' @importFrom sf st_as_sfc st_sf st_set_crs
#' 
NULL


.onAttach <- function(libname, pkgname) {
   packageStartupMessage(
     glue::glue(
       "dbo v. { read.dcf(file=system.file('DESCRIPTION', package=pkgname) )[, 'Version']}"
     )
   )
	
  my.cnf = glue::glue("{rappdirs::user_config_dir('dbo')}/.my.cnf")
  options(dbo.my.cnf = my.cnf)

  if (!file.exists(my.cnf)) {
    packageStartupMessage(
      "There is no configuration file. Run my.cnf() first."
    )
  }

  options(dbo.tz = "Europe/Berlin")
  packageStartupMessage("Server time set to Europe/Berlin.")


  }
