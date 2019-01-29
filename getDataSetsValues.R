# Function to get list of datasets
require(httr)
require(jsonlite)

# example api call: https://play.dhis2.org/2.31.0/api/26/dataValueSets?dataSet=BfMAe6Itzgt&orgUnit=bVZTNrnfn9G&startDate=2018-01-01&endDate=2018-12-31

# Step 1: List of Org Units for dataset (dataset id with org unit id)
# Step 2: Loop using api to get datavalues for dataset with all associated org units
# Step 3: Summarize in dataframe

getTest = function(base.url, username, password,id){
  url = paste0(base.url, "/api/dataSets/", id, "?fields=id,name,shortName,organisationUnits&paging=false")
  r = httr::GET(url, authenticate(username,password), httr::timeout(60))
  if (r$status == 200L){
    print("Logged in succesfully!")
    r = httr::content(r, "text")
    r = jsonlite::fromJSON(r)
    colnames(r$organisationUnits) = "OrgUnitID"
    datasets = as.data.frame(r)
    # datasets = datasets[with(datasets, order(name)),]
  } 
  else {print("Could not login!"); stop()}
  # return(datasets)
}

myusername = "admin"
mypassword = "district"
mybase.url = "https://play.dhis2.org/2.31.0"
test_2 = getTest(mybase.url, myusername, mypassword, id = "BfMAe6Itzgt")
head(test_2)

"https://play.dhis2.org/2.31.0/api/26/dataValueSets?dataSet=BfMAe6Itzgt&orgUnit=bVZTNrnfn9G&startDate=2018-01-01&endDate=2018-12-31"

# The Function start here

getvalues = function(base.url, username, password,id){
  
  datalist = list()
  
  for (i in 1:5)
       {
         url = paste0(base.url, "/api/26/dataValueSets?dataSet=BfMAe6Itzgt&orgUnit=",id[i],"&startDate=2018-01-01&endDate=2018-12-31")
         r = httr::GET(url, authenticate(username,password), httr::timeout(60))
         if (r$status == 200L){
           # print("Logged in succesfully!")
           r = httr::content(r, "text")
           r = jsonlite::fromJSON(r)
           datasets = as.data.frame(r$dataValues)
           datalist[[i]] = datasets
         }
         else {print("Could not login!"); stop()}
  }

  mydatasets = do.call(rbind, datalist)
  
  }

myusername = "admin"
mypassword = "district"
mybase.url = "https://play.dhis2.org/2.31.0"
mytest = getvalues(mybase.url, myusername, mypassword,id = test_2$OrgUnitID)
head(mytest)
dim(mytest)