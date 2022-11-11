
context("test db")


 test_that("test db is created in good order.", {
  
  dbo::test_db(user = USER, host = HOST, db = DB, pwd = PWD)

    expect_true(
      dbCanConnect(RMariaDB::MariaDB(),
        user     = USER, 
        host     = HOST, 
        password = PWD, 
        dbname   = DB
      )
    )


 })
