
if (Sys.getenv("GITHUB_ACTIONS") == "true") {

# see https://github.com/marketplace/actions/actions-setup-mysql
options(dbo.my.cnf = "/etc/my.cnf")

}