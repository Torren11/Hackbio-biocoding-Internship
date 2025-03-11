# Load necessary libraries
library(randomForest)
library(caret)
library(ggplot2)
library(dplyr)

# Load the dataset
# Assuming you have downloaded the file and have the path to it
data <- read.csv("https://raw.githubusercontent.com/HackBio-Internship/2025_project_collection/refs/heads/main/Python/Dataset/methylation.data")

# View the first few rows of the data
head(data)

# Split the data into features (CpG sites) and target (age)
features <- data[, -ncol(data)] # All columns except the last (age)
age <- data[, ncol(data)] # Last column is age

# Normalize the features (CpG methylation data)
features <- scale(features)

# Split data into training and test sets
set.seed(123) # For reproducibility
train_index <- createDataPartition(age, p = 0.8, list = FALSE)
train_features <- features[train_index, ]
train_age <- age[train_index]
test_features <- features[-train_index, ]
test_age <- age[-train_index]

# Function to calculate MSE for a subset of features
calculate_mse <- function(train_features, train_age, test_features, test_age, num_features) {
  # Select the top `num_features` based on randomForest importance
  rf_model <- randomForest(x = train_features, y = train_age, ntree = 500)
  feature_importance <- rf_model$importance
  selected_features <- order(feature_importance[, 1], decreasing = TRUE)[1:num_features]
  
  # Train the random forest model using the selected features
  rf_model <- randomForest(x = train_features[, selected_features], y = train_age, ntree = 500)
  
  # Predict on the test set
  predictions <- predict(rf_model, newdata = test_features[, selected_features])
  
  # Calculate and return MSE
  mse <- mean((predictions - test_age)^2)
  return(mse)
}

# List of feature subset sizes
feature_sizes <- c(1000, 90, 80, 70, 60, 50, 40, 30, 20, 10)

# Store the MSE values for each subset size
mse_values <- sapply(feature_sizes, function(num_features) {
  calculate_mse(train_features, train_age, test_features, test_age, num_features)
})

# Plot MSE vs Number of Features
mse_df <- data.frame(Features = feature_sizes, MSE = mse_values)

ggplot(mse_df, aes(x = Features, y = MSE)) +
  geom_line() +
  geom_point() +
  labs(title = "MSE vs Number of Features", x = "Number of Features", y = "Mean Squared Error (MSE)") +
  theme_minimal()

# Output the MSE values for inspection
print(mse_df)

# Save the plot as an image (optional)
ggsave("mse_vs_features.png", plot = last_plot())
