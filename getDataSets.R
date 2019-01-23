# Function to get list of datasets


require(httr)
require(jsonlite)

getDataSets = function(base.url, username, password){
  url = paste0(base.url, "/api/dataSets?fields=id,name,shortName&paging=false")
  r = httr::GET(url, authenticate(username,password), httr::timeout(60))
  if (r$status == 200L){
    print("Logged in succesfully!")
    r = httr::content(r, "text")
    r = jsonlite::fromJSON(r)
    datasets = as.data.frame(r$dataSets)
    datasets = datasets[with(datasets, order(name)),]
  } 
  else {print("Could not login!"); stop()}
  # return(datasets)
}


# Test Number 2 with demo site 
myusername = "admin"
mypassword = "district"
mybase.url = "https://play.dhis2.org/2.31.0"

test = getDataSets(mybase.url, myusername, mypassword)
head(test)