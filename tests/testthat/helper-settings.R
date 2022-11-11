
HOST <- "127.0.0.1"
USER <- "testuser"
PWD <- "pwd"
DB <- "tests"


dbo::test_db(user = USER, host = HOST, db = DB, pwd = PWD)
