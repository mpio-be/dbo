# ====================================================================================
# TEST BATCH for dbo functions against a localhost db
# User and DB needs to be in place
#   CREATE USER 'testuser'@'%' ;
#   UPDATE mysql.user SET Password=PASSWORD('') WHERE User='testuser' AND Host='%' ;
#   GRANT ALL  ON TESTS.* TO 'testuser'@'%' ;
#   FLUSH PRIVILEGES ;
# ====================================================================================

host     =  '127.0.0.1'
user     =  'testuser'
pwd      =  "pwd"
db       =  'tests'
credpath =  tempfile()

dbo::test_db(user = user, host = host, db = db, pwd = pwd)

# ====================================================================================


context("Credentials")

 test_that("TODO", {

    expect_true( TRUE )


    })


context("Connections")

 test_that("connections are established and closed properly", {
  con = dbcon(config.file = system.file(".my.cnf", package = "dbo"), server = "localhost")
  expect_true( inherits(con, "MariaDBConnection" ) )
  expect_true( closeCon(con ) )
  })

 test_that("when db is given then the default db is active", {
  con = dbcon(config.file = system.file(".my.cnf", package = "dbo"), server = "localhost", db = db)
  expect_true( names(dbGetQuery(con, 'show tables')) == paste0('Tables_in_', db))
  closeCon(con )
  })


 test_that("default dbcon connects to MariaDB", {
  con = dbcon(config.file = system.file(".my.cnf", package = "dbo"), server = "localhost")
  expect_true(class(con) == "MariaDBConnection")
  closeCon(con)
  })

context("dbq")



 test_that("dbq works through an internal connection", {

    o = dbq(
       config.file = system.file(".my.cnf", package = "dbo"), 
       server = "localhost",
       db = db,
       q = "select * from t1 limit 1"
    )
    expect_is(o, 'data.table'  )


    })



 test_that("dbq can fetch a view", {

    con = dbcon(config.file = system.file(".my.cnf", package = "dbo"), server = "localhost", db = db)
    on.exit(closeCon(con))

    x = data.table(a = seq.POSIXt(Sys.time(), by = 10, length.out = 10), ID = 1)
    dbWriteTable(con, 'temp', x, overwrite = TRUE )

    o = dbq(con, "select * from temp")


    expect_is(o, 'data.table'  )


    })





# ====================================================================================

# test_db(user = user, host = host, db = db, pwd = pwd, destroy = TRUE)