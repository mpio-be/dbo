

#' Connect to a database
#'
#' @description     \code{dbcon} returns a database connection.
#'                   If user and password are not given dbq looks for TODO
#' 
#' @param server       server name. IF more server names are given they will be try out in the given order.
#' @param db           active database name
#' @param config.file  path to a config file. See [dbo::my.cnf()]
#' @param driver       MariaDB, defaults to MariaDB
#' @param ...          further arguments passed to [DBI::dbConnect()]
#' 
#' @export
#' @return          a connection object
#' @seealso         [DBI::dbConnect()]
#' @md

dbcon <- function(server = c("scidb","scidb_replica"), db , config.file = getOption('dbo.my.cnf'), driver = "MariaDB", ...) {


  if( driver ==  "MariaDB" ) {
    con = dbConnect(
      drv          = RMariaDB::MariaDB(),
      timezone     = "Europe/Berlin"  , 
      default.file = config.file, 
      group        = server[1],
      timeout      = 3600
    ) |> try(silent = TRUE)

    if(length(server)> 1 && inherits(con, "try-error")){
      warning(glue("Connection to {dQuote(server[1])} failed, using { dQuote(server[2]) }."))

    con <- dbConnect(
      drv          = RMariaDB::MariaDB(),
      default.file = config.file,
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
