dbo::test_db(user = "testuser", host = "127.0.0.1", db = "tests", pwd = "pwd")
my.cnf <- system.file("my.cnf", package = "dbo")
con = dbcon(server = "localhost", config.file = my.cnf, db = "tests")


context("dbSafeWriteTable")

 test_that("dbSafeWriteTable works as expected", {


    x = data.table(col1 = rep('a', 10010), col2 = rnorm(10010))

    dbExecute(con, 'DROP TABLE IF EXISTS temp')

    dbExecute(con, 'CREATE TABLE temp (col1 VARCHAR(50) NULL,col2 FLOAT NULL)' )
    
    expect_true( dbSafeWriteTable(con, 'temp', x, verbose = FALSE) )
    
    dbExecute(con, 'DROP TABLE temp')



    })


context("dbInsertInto")

 test_that("dbInsertInto works as expected", {

    x = data.table(f1 = rep('a', 10), f2 = rnorm(10), f3 = 1)

    dbExecute(con, 'CREATE TABLE temp (f1 VARCHAR(50) ,f2 FLOAT , f99 INT)' )
    
    expect_equal( dbInsertInto(con, 'temp', x) , 10)


    dbExecute(con, 'DROP TABLE temp')
    
    })



dbDisconnect(con)
