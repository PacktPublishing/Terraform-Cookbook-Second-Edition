resource_group_name = "rg-filter"
service_plan_name   = "plan-filter"
environment         = "dev"


web_apps = {
  webapp1 = {
    "name" = "webapptestbook1"
    "os"   = "Linux"
  },
  webapp2 = {
    "name" = "webapptestbook2"
    "os"   = "Linux"
  },
  webapp3 = {
    "name" = "webapptestbook3"
    "os"   = "Windows"
  }
}