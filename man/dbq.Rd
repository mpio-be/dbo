% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dbio_dbq.R
\name{dbq}
\alias{dbq}
\alias{dbq,MariaDBConnection,character,ANY-method}
\alias{dbq,missing,character,ANY-method}
\alias{dbq,MariaDBConnection,character,character-method}
\title{query the database}
\usage{
dbq(con, q, geom, ...)

\S4method{dbq}{MariaDBConnection,character,ANY}(con, q, asUTC = TRUE, ...)

\S4method{dbq}{missing,character,ANY}(con, q, geom, ...)

\S4method{dbq}{MariaDBConnection,character,character}(con, q, geom = "SHAPE", tableNam, ...)
}
\arguments{
\item{con}{a connection object returned by \code{\link{dbcon}}}

\item{q}{a query string. credentials are stored on disk.}

\item{geom}{name of the geometry column. Default to 'SHAPE'}

\item{...}{passed to dbcon}

\item{asUTC}{for MariaDBConnection. not yet implemented}

\item{tableNam}{name of the table containing the geometry.}
}
\value{
a data.frame or a  Spatial*DataFrame (spatial_MySQL) for a SELECT query, or NULL for non-SELECT queries.
}
\description{
query the database using an user-defined connection or a temp connection based on saved credentials.
}
\examples{
\dontrun{
# A connection is made and used by dbq
 con = dbcon('testuser', host =  '127.0.0.1', pwd =  'pwd')
 d1 = dbq(con, 'SELECT * from tests.t1')
 d2 = dbq(con, 'SELECT * from tests.t1')

# A temp. connection is made and closed once the data is retrieved
dbq(q = 'select now()', user = 'testuser', host =  '127.0.0.1', pwd =  'pwd') 
dbq(q = 'select now()', user = 'testuser',host =  '127.0.0.1', pwd =  'pwd') 
		|> print()

# spatial return
s = dbq(con, q = 'select * from tests.t3', geom = 'SHAPE')
s = dbq(con, q = 'select SHAPE from tests.t3', geom = 'SHAPE')
s = dbq(con, q = 'select * from tests.t2', geom = 'SHAPE')

}
}
\seealso{
\code{\link[=my.cnf]{my.cnf()}}, \code{\link[=dbcon]{dbcon()}}
}
