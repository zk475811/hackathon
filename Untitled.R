install.packages("randomForest", repos = "http://cran.us.r-project.org")
library(randomForest)

# docs at https://www.rdocumentation.org/packages/randomForest/versions/4.6-12

# FUNCTIONS -----------------------------------

# data set read function
loadDataCSV <- function(path) {
  # colClasses is used to set the type of the column
  # if using 1 and 0, then change to factor otherwise it will perform regression
  return <- read.csv(
    path,
    head=TRUE,
    sep = ",",
    colClasses = c("success"="factor")
  )
}

argCheck <- function(args) {
  if(length(args) != 1) {
    stop("One argument should be provided as the data input file path")
  }
}

# END FUNCTIONS -------------------------------

# load the data set and predictors
args <- commandArgs(trailingOnly = TRUE)
argCheck(args)
studentData <- loadDataCSV(args[1])

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
