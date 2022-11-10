#' Get table comments 
#'
#' @description  Extract table comments to data.table
#'
#' @param     con        a *Connection object. See [dbo::dbcon()]
#' @param     tableName  table name
#' @param     db         optional database name.
#' @export
#' @md


tableComments <- function(con, tableName, db) {

    sql = glue("SELECT COLUMN_NAME `Column`, COLUMN_COMMENT description FROM  information_schema.COLUMNS
                WHERE TABLE_NAME = {shQuote(tableName)}")
    if(!missing(db))
     sql = glue("{sql} AND TABLE_SCHEMA = {shQuote(db)}")
      
    dbq(con, sql)  






}