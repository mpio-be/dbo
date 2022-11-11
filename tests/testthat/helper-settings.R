
if (Sys.getenv("GITHUB_ACTIONS") == "true") {

# see https://github.com/marketplace/actions/actions-setup-mysql

file.copy(system.file("my.cnf", package = "dbo"), "~/.my.cnf")

print("++++++++++++++++++++++++++++++++++++++++++++++++++++")
print(getwd())

options(dbo.my.cnf = "~/.my.cnf")

}