



my.cnf <- system.file("my.cnf", package = "dbo")
con <- dbo::dbcon(server = "localhost", config.file = my.cnf, db = "tests")


context("get queries")

test_that("tableComments gets table comments in a DT", {

  o= tableComments(con, "t1")
  expect_is(o, "data.table")


})
