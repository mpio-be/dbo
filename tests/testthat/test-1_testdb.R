# ====================================================================================
# TEST BATCH for dbo functions against a localhost db
# User needs to be in place
#   CREATE USER 'testuser'@'%' ;
#   UPDATE mysql.user SET Password=PASSWORD('') WHERE User='testuser' AND Host='%' ;
#   GRANT ALL  ON TESTS.* TO 'testuser'@'%' ;
#   FLUSH PRIVILEGES ;
# ====================================================================================

HOST <- "127.0.0.1"
USER <- "testuser"
PWD  <- "pwd"
DB   <- "tests"

context("test db")


 test_that("test db is created in good order.", {
  
  dbo::test_db(user = USER, host = HOST, db = DB, pwd = PWD)

    expect_true(
      dbCanConnect(RMariaDB::MariaDB(),
        user = USER, 
        host = HOST, 
        password = PWD, 
        dbname = DB
      )
    )


 })
