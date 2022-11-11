

#' Connect to a database
#'
#' @description     \code{dbcon} returns a database connection.
#'                   If user and password are not given dbq looks for TODO
#' 
#' @param server       server name. If more server names are given they will be try out in the given order.
#' @param db           active database name
#' @param driver       MariaDB
#' @param ...          further arguments passed to [DBI::dbConnect()]
#' 
#' @export
#' @return          a connection object
#' @seealso         [DBI::dbConnect()]
#' @note           [DBI::dbConnect()] timezone and default.file (.my.cnf) are set throug options() at startup. 
#' @md

dbcon <- function(server = c("scidb","scidb_replica"), db , driver = "MariaDB", ...) {


  if( driver ==  "MariaDB" ) {
    con = dbConnect(
      drv          = RMariaDB::MariaDB(),
      timezone     = getOption("dbo.tz")  , 
      default.file = getOption('dbo.my.cnf'), 
      group        = server[1],
      timeout      = 3600
    ) |> try(silent = TRUE)

    if(length(server)> 1 && inherits(con, "try-error")){
      warning(glue("Connection to {dQuote(server[1])} failed, using { dQuote(server[2]) }."))

    con <- dbConnect(
      drv          = RMariaDB::MariaDB(),
      timezone     = getOption("dbo.tz"),
      default.file = getOption('dbo.my.cnf'),
      group        = server[2],
      timeout      = 3600
    )


    }

    if (!missing(db)) {
      dbExecute(con, glue("USE {db}"))
    }

    }

    con

  }

#' @rdname dbcon
#' @param con    The connection object.
#' @export
setGeneric("closeCon", function(con)   standardGeneric("closeCon") )


#' @export
#' @rdname dbcon
setMethod("closeCon",
          signature  = c(con = "MariaDBConnection"),
          definition = function(con) {
      dbDisconnect(con)
    })
