install.packages("randomForest", repos = "http://cran.us.r-project.org")
install.packages("RMySQL", repos = "http://cran.us.r-project.org")
library(randomForest)
library(RMySQL)

# docs at https://www.rdocumentation.org/packages/randomForest/versions/4.6-12

# FUNCTIONS -----------------------------------

# data set read function
loadDataCSV <- function() {
  # colClasses is used to set the type of the column
  # if using 1 and 0, then change to factor otherwise it will perform regression
  return <- read.csv(
    Sys.getenv("CSV_FILE_PATH"),
    head=TRUE,
    sep = ",",
    colClasses = c("success"="factor")
  )
}

loadDataMySQL <- function() {
  mydb <- dbConnect(
    MySQL(),
    user=Sys.getenv("DATABASE_USER"),
    password=Sys.getenv("DATABASE_PASSWORD"),
    dbname=Sys.getenv("DATABASE_NAME"),
    host=Sys.getenv("DATABASE_HOST")
  )
  
  result <- dbSendQuery(mydb, "select * from table")
  mySqlData <- fetch(result, n = -1)
  
  mydb <- dbDisconnect()
  
  return <- mySqlData
}

loadData <- function() {
  args <- commandArgs(trailingOnly = TRUE)
  argCheck(args)
  if(args[1] == "db") {
    return <- loadDataMySQL()
  } else if(args[1] == "csv") {
    return <- loadDataCSV()
  } else {
    stop("Argument is data source type (csv, db)")
  }
}

argCheck <- function(args) {
  if(length(args) != 1) {
    stop("Argument is data source type (csv, db)")
  }
}

# END FUNCTIONS -------------------------------

# load the data set and predictors
studentData <- loadData()

# create the forest
set.seed(12345)

train <- sample(1:nrow(studentData),nrow(studentData) * .75)

studentForest <- randomForest(
  success ~ .,
  data = studentData,
  subset = train,
  ntree = 500,
  importance = TRUE
)

# view the forest results 
print(studentForest)

# importance of each predictor
# type = 1 for mean decrease in accuracy, type = 2 for mean decrease impurity
# print(importance(studentForest, type = 2))
print(importance(studentForest))
