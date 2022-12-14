% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dbio_dbcon.R
\name{dbcon}
\alias{dbcon}
\alias{closeCon}
\alias{closeCon,MariaDBConnection-method}
\title{Connect to a database}
\usage{
dbcon(server = c("scidb", "scidb_replica"), db, driver = "MariaDB", ...)

closeCon(con)

\S4method{closeCon}{MariaDBConnection}(con)
}
\arguments{
\item{server}{server name. If more server names are given they will be try out in the given order.}

\item{db}{active database name}

\item{driver}{MariaDB}

\item{...}{further arguments passed to \code{\link[DBI:dbConnect]{DBI::dbConnect()}}}

\item{con}{The connection object.}
}
\value{
\if{html}{\out{<div class="sourceCode">}}\preformatted{     a connection object
}\if{html}{\out{</div>}}
}
\description{
\if{html}{\out{<div class="sourceCode">}}\preformatted{\code{dbcon} returns a database connection.
              If user and password are not given dbq looks for TODO
}\if{html}{\out{</div>}}
}
\note{
\if{html}{\out{<div class="sourceCode">}}\preformatted{      [DBI::dbConnect()] timezone and default.file (.my.cnf) are set throug options() at startup. 
}\if{html}{\out{</div>}}
}
\seealso{
\if{html}{\out{<div class="sourceCode">}}\preformatted{    [DBI::dbConnect()]
}\if{html}{\out{</div>}}
}
