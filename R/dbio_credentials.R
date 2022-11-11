
#' manage database credentials
#' manage database credentials for for different hosts .
#' @param delete   removes the config file (default to FALSE).
#' @export 
#' 
my.cnf <- function(delete = FALSE) {

  path = getOption("dbo.my.cnf")

  if(!delete) {
    if(!file.exists(path)){
      dir.create(dirname(path), recursive = TRUE, showWarnings = FALSE)

      file.copy(system.file("my.cnf", package = "dbo"), path)

    }

    if(interactive()) {
      message("Fill in one or several configuration groups and save.")
      file.edit(path)
    }

  }

  if(delete) file.remove(path)



}