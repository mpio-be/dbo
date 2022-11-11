
con = dbcon(server = "localhost",db = "tests")


context("DB I/O")

 test_that("dbUpdate  works", {


    x = data.table(y = letters[1:5], pk = 1:5)
    con = dbcon(db = 'tests')
    dbWriteTable(con, "X", x, row.names = FALSE, overwrite =TRUE)
    x1 = x[1:2][,y := c("Z", "W")]
   
    expect_true(dbUpdate(con, "X", x1, by = "pk", which = "y"))

    expect_equal(
        dbq(con, "SELECT y FROM X limit 1")$y, 
        "Z"
    )


    dbExecute(con, "DROP table X")



    })

 test_that("dbSafeWriteTable works as expected", {


    x = data.table(col1 = rep('a', 10010), col2 = rnorm(10010))

    dbExecute(con, 'DROP TABLE IF EXISTS temp')

    dbExecute(con, 'CREATE TABLE temp (col1 VARCHAR(50) NULL,col2 FLOAT NULL)' )
    
    expect_true( dbSafeWriteTable(con, 'temp', x, verbose = FALSE) )
    
    dbExecute(con, 'DROP TABLE temp')



    })




 test_that("dbInsertInto works as expected", {

    x = data.table(f1 = rep('a', 10), f2 = rnorm(10), f3 = 1)

    dbExecute(con, 'CREATE TABLE temp (f1 VARCHAR(50) ,f2 FLOAT , f99 INT)' )
    
    expect_equal( dbInsertInto(con, 'temp', x) , 10)


    dbExecute(con, 'DROP TABLE temp')
    
    })



dbDisconnect(con)
