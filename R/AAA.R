utils::globalVariables(
  c(
    "db",
    ".pk",
    "scinam_tdata",
    "scinam_ttax",
    "N",
    ".duplicates",
    "geometry"
  )
)
NULL


   


#' \strong{d}ata \strong{b}ase interface for scidb.\strong{o}rn.mpg.de
#'
#' An interface to \href{http://scidb.mpio.orn.mpg.de}{scidb.mpio.orn.mpg.de} databases
#'
#'
#' @name dbo
#' @docType package
#'
#' @author Mihai Valcu \email{valcu@@orn.mpg.de}
#'
#' @import     methods utils data.table
#' @import     RMariaDB DBI
#' @importFrom stringr str_trim
#' @importFrom stats rnorm rpois runif
#' @importFrom stringr str_detect str_glue str_split regex
#' @importFrom sf st_as_sfc st_sf st_set_crs
#' 
NULL


.onAttach <- function(libname, pkgname) {
	dcf <- read.dcf(file=system.file("DESCRIPTION", package=pkgname) )
  msg = paste(pkgname, dcf[, "Version"])
	packageStartupMessage()
	


  }
