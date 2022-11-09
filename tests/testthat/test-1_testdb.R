# ====================================================================================
# TEST BATCH for dbo functions against a localhost db
# User needs to be in place
#   CREATE USER 'testuser'@'%' ;
#   UPDATE mysql.user SET Password=PASSWORD('') WHERE User='testuser' AND Host='%' ;
#   GRANT ALL  ON TESTS.* TO 'testuser'@'%' ;
#   FLUSH PRIVILEGES ;
# ====================================================================================

host <- "127.0.0.1"
user <- 
pwd <- "pwd"
db <- "tests"

context("test db")


 test_that("test db is created in good order.", {
  
  dbo::test_db(user = "testuser", host = "127.0.0.1", db = "tests", pwd = "pwd")

    expect_true(
      dbCanConnect(RMariaDB::MariaDB(),
        user = user, 
        host = host, 
        password = pwd, 
        dbname = db
      )
    )


 })
