// Put env variables inside of an .Rprofile file in the working directory such as:

Sys.setenv(DATABASE_USER = "username")
---------------------------------------------------

1. Find out how to put data into MySQL database
2. Pull data from database and perform machine learning algorithms
3. Put data where it needs to be for visuals

Identify what attributes universities can look at to determine if a student may need extra support to be successful after college.
1. This means we need to determine what success is
2. Determine what attributes may make a student less successful after college.

----- Feature Selection
Filter out features, different that dimensionality reduction.

----- Random Forests for Feature Selection
Random forests provide two methods for feature selection:
  1. Mean decrease impurity
  2. Mean decrease accuracy

----- Mean Decrease Impurity
- Random forests consist of a number of decision trees
- Every node in the decision tree is a condition on a single feature
- The measure based on which locally optimal condition is chosen is called impurity
- For classification it is typically Gini impurity or information gain/entropy
- For regression trees it is variance
- Thus when training a tree it can be computed how much each feature decreases the weighted impurity in a tree
- For a forest the impurity decrease from each feature can be averaged and the features are ranked according to this measure

----- Things to consider with impurity based ranking
- Selection is biased towards preferring variables with more categories (does this mean linear values?)
- When a dataset has two or more correlated features, an of the features can be used from the point of view of the model, but once one of them is used the significance of the other is significantly reduced since effectively the impurity is already removed by the first feature
- As a consequence they will have lower reported importance, this is fine for reducing the number of features

----- Mean Decrease Accuracy 
- Measure the impact of each feature on the accuracy of the model
- Permute the values of each feature and measure how much permutation decreases the accuracy of the model

----- The Random Forest Package for R
- install.packages("randomForest")
- library(randomForest)
- randomForest(formula, data)

----- Example Script
library(randomForest)
output.forest <- randomForest(nativeSpeaker ~ age + shoeSize + score, data = readingSkills)

print(output.forest)

# view importance of each predictor
print(importance(fit, type = 2) 
----- End Example Script

----- Documentation on randomForest library
url: https://www.rdocumentation.org/packages/randomForest/versions/4.6-12/topics/randomForest

