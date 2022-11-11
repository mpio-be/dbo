

context("Connections")

 test_that("connections are established and closed properly", {
  con = dbcon(server = "localhost")
  expect_true( inherits(con, "MariaDBConnection" ) )
  expect_true( closeCon(con ) )
  })

 test_that("when db is given then the default db is active", {
  con = dbcon(server = "localhost", db = "tests")
  expect_true( names(dbGetQuery(con, 'show tables')) == 'Tables_in_tests')
  closeCon(con )
  })


 test_that("default dbcon connects to MariaDB", {
  con = dbcon(server = "localhost")
  expect_true(class(con) == "MariaDBConnection")
  closeCon(con)
  })

context("dbq")

 test_that("dbq works through an internal connection", {
   o = dbq(
      server = "localhost",
      db = "tests",
      q = "select * from T1 limit 1"
      )
   expect_is(o, "data.table")
   })

 test_that("dbq can fetch a view", {

    con = dbcon(server = "localhost", db = "tests")
    on.exit(closeCon(con))

    x = data.table(a = seq.POSIXt(Sys.time(), by = 10, length.out = 10), ID = 1)
    dbWriteTable(con, 'temp', x, overwrite = TRUE )

    o = dbq(con, "select * from temp")


    expect_is(o, 'data.table'  )


   })
