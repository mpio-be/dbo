


con <- dbo::dbcon(server = "localhost", db = "tests")

context("get queries")

test_that("tableComments gets table comments in a DT", {

  o= tableComments(con, "T1")
  expect_is(o, "data.table")


})
