# Task Code 2.1:Microbiology
# Load necessary libraries
library(ggplot2)
library(dplyr)
library(tidyr)

# Load the dataset
url <- "https://raw.githubusercontent.com/HackBio-Internship/2025_project_collection/refs/heads/main/Python/Dataset/mcgc.tsv"
data <- read.csv(url, sep = "\t")

# View the first few rows of the dataset to understand its structure
head(data)

# Task 1: Plot all growth curves (OD600 vs Time) for different Strains
# For each strain, plot knock-out (-) and knock-in (+) strains overlayed on top of each other
ggplot(data, aes(x = Time, y = OD600, color = Strain, linetype = Mutant)) +
  geom_line() +
  labs(title = "Growth Curves: OD600 vs Time", x = "Time (hours)", y = "OD600 (Optical Density)") +
  theme_minimal() +
  scale_color_manual(values = c("blue", "red", "green", "purple")) + # Customize the color scale for clarity
  theme(legend.position = "top")

# Task 2: Determine the time to reach carrying capacity for each strain/mutant
# Group by Strain and Mutant, then find the last time point (assuming carrying capacity is the last OD600 value)
carrying_capacity_time <- data %>%
  group_by(Strain, Mutant) %>%
  summarise(time_to_capacity = max(Time[OD600 == max(OD600)]), .groups = "drop")

# View the result for time to capacity
print(carrying_capacity_time)

# Task 3: Generate a scatter plot of the time it takes to reach carrying capacity for knock-out and knock-in strains
ggplot(carrying_capacity_time, aes(x = Mutant, y = time_to_capacity, color = Strain)) +
  geom_point(size = 4) +
  labs(title = "Time to Reach Carrying Capacity (Scatter Plot)", x = "Strain Type", y = "Time to Carrying Capacity (hours)") +
  theme_minimal() +
  scale_color_manual(values = c("blue", "red", "green", "purple"))

# Task 4: Generate a box plot of the time it takes to reach carrying capacity for knock-out and knock-in strains
ggplot(carrying_capacity_time, aes(x = Mutant, y = time_to_capacity, fill = Mutant)) +
  geom_boxplot() +
  labs(title = "Time to Reach Carrying Capacity (Box Plot)", x = "Strain Type", y = "Time to Carrying Capacity (hours)") +
  theme_minimal() +
  scale_fill_manual(values = c("skyblue", "salmon"))

# Task 5: Is there a statistical difference in the time it takes for knock-out strains to reach their maximum carrying capacity compared to the knock-in strains?
# Perform a t-test to compare the times for knock-out and knock-in strains
t_test_result <- t.test(time_to_capacity ~ Mutant, data = carrying_capacity_time)
print(t_test_result)

# Observations:
# The p-value from the t-test will help determine if there is a significant difference in the time to reach carrying capacity
# A p-value below 0.05 suggests a statistically significant difference between the two groups (knock-out vs knock-in).
