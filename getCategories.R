# Function to get list of indicators


require(httr)
require(jsonlite)

getCategories = function(base.url, username, password){
  url = paste0(base.url, "/api/categories?fields=id,name,shortName&paging=false")
  r = httr::GET(url, authenticate(username,password), httr::timeout(60))
  if (r$status == 200L){
    print("Logged in succesfully!")
    r = httr::content(r, "text")
    r = jsonlite::fromJSON(r)
    categories = as.data.frame(r$categories)
    categories = categories[with(categories, order(name)),]
  } 
  else {print("Could not login!"); stop()}

}


# Test with demo site
myusername = "admin"
mypassword = "district"
mybase.url = "https://play.dhis2.org/2.31.0"

test = getCategories(mybase.url, myusername, mypassword)
head(test)