#Task Code 2.7: Public Health
# Load necessary libraries
library(ggplot2)
library(dplyr)

# Load the NHANES dataset (assuming a CSV file; update the path if needed)
data_url <- "https://raw.githubusercontent.com/HackBio-Internship/public_datasets/main/R/nhanes.csv"
nhanes_data <- read.csv(data_url)

# Check the first few rows of the data to understand its structure
head(nhanes_data)

# Task 1: Process all NAs (convert to zero or delete rows with NA)
# Let's convert NAs to zero for numeric columns
nhanes_data_clean <- nhanes_data %>%
  mutate(across(where(is.numeric), ~replace(., is.na(.), 0)))

# Task 2: Visualize the distribution of BMI, Weight, Weight in pounds, and Age with histograms
# Plot the histograms
ggplot(nhanes_data_clean, aes(x = BMI)) +
  geom_histogram(binwidth = 1, fill = "skyblue", color = "black", alpha = 0.7) +
  labs(title = "BMI Distribution", x = "BMI", y = "Frequency") +
  theme_minimal()

ggplot(nhanes_data_clean, aes(x = Weight)) +
  geom_histogram(binwidth = 5, fill = "skyblue", color = "black", alpha = 0.7) +
  labs(title = "Weight Distribution", x = "Weight (kg)", y = "Frequency") +
  theme_minimal()

# Convert weight to pounds (Weight in kg * 2.2)
nhanes_data_clean$Weight_pounds <- nhanes_data_clean$Weight * 2.2

ggplot(nhanes_data_clean, aes(x = Weight_pounds)) +
  geom_histogram(binwidth = 10, fill = "skyblue", color = "black", alpha = 0.7) +
  labs(title = "Weight in Pounds Distribution", x = "Weight (pounds)", y = "Frequency") +
  theme_minimal()

ggplot(nhanes_data_clean, aes(x = Age)) +
  geom_histogram(binwidth = 5, fill = "skyblue", color = "black", alpha = 0.7) +
  labs(title = "Age Distribution", x = "Age", y = "Frequency") +
  theme_minimal()

# Task 3: Calculate the mean 60-second pulse rate
mean_pulse_rate <- mean(nhanes_data_clean$Pulse_60s, na.rm = TRUE)
print(paste("Mean 60-second pulse rate: ", mean_pulse_rate))

# Task 4: Find the range of diastolic blood pressure
range_diastolic_bp <- range(nhanes_data_clean$Diastolic_BP, na.rm = TRUE)
print(paste("Range of diastolic blood pressure: ", range_diastolic_bp[1], "-", range_diastolic_bp[2]))

# Task 5: Calculate the variance and standard deviation for income
variance_income <- var(nhanes_data_clean$Income, na.rm = TRUE)
sd_income <- sd(nhanes_data_clean$Income, na.rm = TRUE)
print(paste("Variance of income: ", variance_income))
print(paste("Standard deviation of income: ", sd_income))

# Task 6: Visualize the relationship between weight and height, colored by gender, diabetes, and smoking status
ggplot(nhanes_data_clean, aes(x = Height, y = Weight)) +
  geom_point(aes(color = factor(Gender), shape = factor(Diabetes), size = factor(Smoking_Status))) +
  labs(title = "Relationship Between Weight and Height", x = "Height (cm)", y = "Weight (kg)") +
  theme_minimal() +
  scale_color_manual(values = c("blue", "pink")) + # Example colors for gender
  theme(legend.position = "bottom")

# Task 7: Conduct t-tests and make conclusions based on the p-value

# t-test between Age and Gender
t_test_age_gender <- t.test(Age ~ Gender, data = nhanes_data_clean)
print(t_test_age_gender)

# t-test between BMI and Diabetes
t_test_bmi_diabetes <- t.test(BMI ~ Diabetes, data = nhanes_data_clean)
print(t_test_bmi_diabetes)

# t-test between Alcohol Year and Relationship Status
t_test_alcohol_relationship <- t.test(Alcohol_Year ~ Relationship_Status, data = nhanes_data_clean)
print(t_test_alcohol_relationship)
