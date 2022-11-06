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

 test_that("Save & remove credentials works - using non-default path", {

    expect_true( saveCredentials(user, pwd, host = host, path = credpath) )
    con = dbcon(user, drive = "MariaDB", host = host, path = credpath); on.exit(closeCon(con))
    expect_true( inherits(con, "MariaDBConnection" ) )
    removeCredentials(path = credpath)

    })

 test_that("Save credentials to testuser to default location", {

    expect_true( saveCredentials(user, pwd, host = host) )

    })

 test_that("credentials file exists", {
    expect_true( saveCredentials(user, pwd, host = host, path = credpath) )
    expect_true( credentialsExist(host, path = credpath))

  })


 test_that("Wrong credentials return error", {

    expect_true( saveCredentials(user, 'wrong pwd', host = host, path = credpath) )

    expect_error ( dbcon('test', host = host,  path = credpath ) )

    expect_true( saveCredentials(user, pwd, host = host, path = credpath) )


    })

context("Connections")

 test_that("connections are established and closed properly", {
  con = dbcon(user, pwd, host = host, driver = "MariaDB" )
  expect_true( inherits(con, "MariaDBConnection" ) )
  expect_true( closeCon(con ) )
  })

 test_that("when db is given then the default db is active", {
  con = dbcon(user, pwd, host = host, driver = "MariaDB", db = db, path = credpath)
  expect_true( names(dbGetQuery(con, 'show tables')) == paste0('Tables_in_', db))
  closeCon(con )
  })


 test_that("default dbcon connects to MariaDB", {
  con = dbcon(user, pwd, host = host,  path = credpath)
  expect_true(class(con) == "MariaDBConnection")
  closeCon(con)
  })

context("dbq")



 test_that("dbq works through an internal connection", {

    o = dbq(user=user,host = host, pwd = pwd, db = db, path = credpath , q = "select * from t1 limit 1")
    expect_is(o, 'data.table'  )


    })



 test_that("dbq can fetch a view", {

    con = dbcon(user=user,host = host, pwd = pwd, db = db, path = credpath ); on.exit(closeCon(con))

    x = data.table(a = seq.POSIXt(Sys.time(), by = 10, length.out = 10), ID = 1)
    dbWriteTable(con, 'temp', x, overwrite = TRUE )

    o = dbq(con, "select * from temp")


    expect_is(o, 'data.table'  )


    })





# ====================================================================================

# test_db(user = user, host = host, db = db, pwd = pwd, destroy = TRUE)