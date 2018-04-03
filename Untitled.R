install.packages("randomForest")
library(randomForest)

# docs at https://www.rdocumentation.org/packages/randomForest/versions/4.6-12

# load the data set and predictors
studentData <- loadDataCSV("R_DATA_LOCATION")

# create the forest
set.seed(12345)
studentForest <- randomForest(
  success ~,
  data = studentData,
  ntree = 500,
  importance = TRUE
)

# view the forest results 
print(studentForest)

# importance of each predictor
# type = 1 for mean decrease in accuracy, type = 2 for mean decrease impurity
# print(importance(studentForest, type = 2))
print(importance(studentForest))

# data set read function
loadData <- function(sysVar) {
  location <- Sys.getenv(sysVar)
  return <- read.csv(location)
}