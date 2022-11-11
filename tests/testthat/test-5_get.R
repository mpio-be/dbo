


con <- dbo::dbcon(server = "localhost", db = "tests")

context("get queries")

test_that("tableComments gets table comments in a DT", {

  o= tableComments(con, "T1")
  expect_is(o, "data.table")


})


test_that("datetime is returned correctly", {

  x = data.frame(dt = Sys.time())
  dbWriteTable(con, "temp", x, temporary = TRUE, row.names = FALSE, overwrite = TRUE)
  o = dbReadTable(con, "temp")

  expect_equal(as.double(x), as.double(o))


})
