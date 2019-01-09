# Function to get list of indicators


require(httr)
require(jsonlite)

getCategoryOptions = function(base.url, username, password){
  url = paste0(base.url, "/api/categoryOptions?fields=id,name,shortName&paging=false")
  r = httr::GET(url, authenticate(username,password), httr::timeout(60))
  if (r$status == 200L){
    print("Logged in succesfully!")
    r = httr::content(r, "text")
    r = jsonlite::fromJSON(r)
    categoryOptions = as.data.frame(r$categoryOptions)
    categoryOptions = categoryOptions[with(categoryOptions, order(name)),]
  } 
  else {print("Could not login!"); stop()}

}


# Test with demo site
myusername = "admin"
mypassword = "district"
mybase.url = "https://play.dhis2.org/2.31.0"

test = getCategoryOptions(mybase.url, myusername, mypassword)
head(test)