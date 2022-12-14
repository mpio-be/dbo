#' query the database
#'
#' query the database using an user-defined connection or a temp connection based on saved credentials.
#' 
#' @param con 		 a connection object returned by \code{\link{dbcon}}
#' @param q 		 a query string. credentials are stored on disk.
#' @param asUTC		 for MariaDBConnection. not yet implemented
#' @param geom 		 name of the geometry column. Default to 'SHAPE'
#' @param tableNam   name of the table containing the geometry. 
#' @param ...        passed to dbcon
#'
#' 
#' @seealso [dbo::my.cnf()], [dbo::dbcon()]
#' 
#' @export
#' @md
#' @return a data.frame or a  Spatial*DataFrame (spatial_MySQL) for a SELECT query, or NULL for non-SELECT queries.
#' @examples
#' \dontrun{
#' # A connection is made and used by dbq
#'  con = dbcon('testuser', host =  '127.0.0.1', pwd =  'pwd')
#'  d1 = dbq(con, 'SELECT * from tests.t1')
#'  d2 = dbq(con, 'SELECT * from tests.t1')
#'
#' # A temp. connection is made and closed once the data is retrieved
#' dbq(q = 'select now()', user = 'testuser', host =  '127.0.0.1', pwd =  'pwd') 
#' dbq(q = 'select now()', user = 'testuser',host =  '127.0.0.1', pwd =  'pwd') 
#' 		|> print()
#'
#' # spatial return
#' s = dbq(con, q = 'select * from tests.t3', geom = 'SHAPE')
#' s = dbq(con, q = 'select SHAPE from tests.t3', geom = 'SHAPE')
#' s = dbq(con, q = 'select * from tests.t2', geom = 'SHAPE')
#' 
#' }


setGeneric("dbq", function(con,q, geom, ...)   standardGeneric("dbq") )


#' @rdname dbq
#' @export
setMethod("dbq",signature  = c(con = "MariaDBConnection", q = "character"),
		definition = function(con, q, asUTC = TRUE, ...) {
		

		if( isNotSelect(q) )
			warning('For queries returning no data use dbExecute().')

	
		o =  dbGetQuery(con, q, ...) 
  	setDT(o)

		o

		 }
		)

#' @rdname dbq
#' @export
setMethod("dbq",signature  = c(con = "missing", q = "character"),
		definition = function(q, ...) {
		
		if( isNotSelect(q) )
   warning("For queries returning no data use dbExecute().")

		con = dbcon(...); on.exit(closeCon(con))
		o = dbGetQuery(con, q) 
		setDT(o)
		o

		}
		)


#' @rdname dbq
#' @export
setMethod("dbq",signature  = c(con = "MariaDBConnection", q = "character", geom = 'character'),
		definition = function(con, q, geom = 'SHAPE', tableNam , ...) {
		
		if( isNotSelect(q) )
			stop('Only SELECT queries are supported. Use dbExecute() for non-SELECT queries.')

		
		# re-format sql	
		newq = SQL2spatialSQL(q, geometry = geom)

		# get data
		o =  dbGetQuery(con, newq) 
		setDT(o)
		setnames(o, geom, 'geometry')
		o[, geometry := list(st_as_sfc(geometry)) ]
		o = st_sf(o)

		# get table name
		if(missing(tableNam))
			tableNam = SQL2tableName(q)

		# try get spatial reference 
			crs = try( getCRSfromDB(con, tableNam), silent = TRUE)


		if( inherits(crs, 'crs'))
			o = st_set_crs(o, crs) 

		o

		}
		)
