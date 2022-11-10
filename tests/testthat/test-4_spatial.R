my.cnf <- system.file("my.cnf", package = "dbo")
con = dbcon(server = "localhost", config.file = my.cnf, db = "tests")


context("spatial")

test_that("dbq returns a sf object when geom is given", {

  s = dbq(con, 'select SHAPE from tests.t3', geom = 'SHAPE')
  expect_true(inherits(s, "sf") )

  }) 

test_that("spatial dbq should fail for select * FROM queries", {

  expect_error( dbq(con, 'select * from tests.t3', geom = 'SHAPE') )

  }) 


test_that("spatial dbq plays with JOINS", {

  expect_warning(
    dbq(con, q = "SELECT t3.OGR_FID, t3.SHAPE, t1.n2 FROM
              t3 JOIN t1 ON t3.OGR_FID = t1.n1
                WHERE n1 < 4", geom = "SHAPE")
    )

    }) 

  
dbDisconnect(con)
