

#' Connect to a database
#'
#' @description     \code{dbcon} returns a database connection.
#'                   If user and password are not given dbq looks for TODO
#' 
#' @param driver    MariaDB or mysql_gdal, ... Defaults to MariaDB
#' @param db        active database name
#' @param ...       pass to dbConnect
#' 
#' @export
#' @return          a connection object
#' @seealso         \code{\link{xxxxxxx}}

dbcon <- function(driver = "MariaDB", server = "scidb", db , config.file, ...) {


  if( driver ==  "MariaDB" ) {
    con = dbConnect(
      dr             = RMariaDB::MariaDB(),
      # timezone     = "Europe/Berlin", TODO
      default.file = config.file, 
      group        = server,
      timeout      = 3600,
      ...
    )

    if (!missing(db)) {
      dbExecute(con, glue("USE {db}"))
    }

    }




  if(driver == 'mysql_gdal') {
    if (missing(db)) stop("database name is required for mysql_gdal")
    # TODO parse .my.cnf?
    con = paste0("MYSQL:", db, ",user=", user, ",host=", host, ",password=", pwd)
  }


  return(con)

  }

#' @rdname dbcon
#' @export
setGeneric("closeCon", function(con)   standardGeneric("closeCon") )


#' @export
#' @rdname dbcon
setMethod("closeCon",
          signature  = c(con = "MariaDBConnection"),
          definition = function(con) {
      dbDisconnect(con)
    })
