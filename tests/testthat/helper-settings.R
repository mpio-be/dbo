
if (Sys.getenv("GITHUB_ACTIONS") == "true") {

# see https://github.com/marketplace/actions/actions-setup-mysql

file.copy(system.file("my.cnf", package = "dbo"), "/home/runner/.my.cnf")



options(dbo.my.cnf = "/home/runner/.my.cnf")

}