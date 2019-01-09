# Function to get list of indicators


require(httr)
require(jsonlite)

getOrganisationUnits = function(base.url, username, password){
  url = paste0(base.url, "/api/organisationUnits?fields=id,name,shortName&paging=false")
  r = httr::GET(url, authenticate(username,password), httr::timeout(60))
  if (r$status == 200L){
    print("Logged in succesfully!")
    r = httr::content(r, "text")
    r = jsonlite::fromJSON(r)
    organisationUnits = as.data.frame(r$organisationUnits)
    organisationUnits = organisationUnits[with(organisationUnits, order(name)),]
  } 
  else {print("Could not login!"); stop()}
  
}


# Test with demo site
myusername = "admin"
mypassword = "district"
mybase.url = "https://play.dhis2.org/2.31.0"

test = getOrganisationUnits(mybase.url, myusername, mypassword)
head(test)