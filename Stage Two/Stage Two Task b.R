#Task Code 2.3: Botany and Plant Science
#Metab
# Load necessary libraries
library(ggplot2)
library(dplyr)

# Load the dataset
url <- "https://raw.githubusercontent.com/HackBio-Internship/2025_project_collection/refs/heads/main/Python/Dataset/Pesticide_treatment_data.txt"
data <- read.delim(url)

# Inspect the first few rows of the dataset
head(data)

# Calculate ΔM for Wild Type and Mutants
data <- data %>%
  mutate(ΔM_WT = DMSO_WT_24h - DMSO_WT_8h,
         ΔM_Mutant = DMSO_Mutant_24h - DMSO_Mutant_8h)


# Inspect the new columns
head(data)

# Scatter plot of ΔM for WT and Mutants
ggplot(data, aes(x = ΔM_WT, y = ΔM_Mutant)) +
  geom_point(color = "blue") +
  geom_abline(slope = 1, intercept = 0, color = "red") + # Line with slope 1 and intercept 0
  labs(title = "Difference in Metabolic Response (ΔM) for WT and Mutants",
       x = "ΔM for Wild Type (WT)",
       y = "ΔM for Mutants") +
  theme_minimal()

# Calculate residuals (difference between the data points and the fitted line y = x)
data <- data %>%
  mutate(residual = ΔM_Mutant - ΔM_WT)

# Inspect the residuals
head(data)

# Set the cut-off value for residual
cut_off <- 0.3

# Create a new column to categorize metabolites based on residuals
data <- data %>%
  mutate(color = ifelse(abs(residual) <= cut_off, "grey", "salmon"))

# Plot with colored points
ggplot(data, aes(x = ΔM_WT, y = ΔM_Mutant, color = color)) +
  geom_point() +
  geom_abline(slope = 1, intercept = 0, color = "red") + # Line with slope 1 and intercept 0
  labs(title = "Colored Difference in Metabolic Response (ΔM) for WT and Mutants",
       x = "ΔM for Wild Type (WT)",
       y = "ΔM for Mutants") +
  scale_color_identity() + # Use the color values directly
  theme_minimal()

# Filter metabolites that are outliers (salmon color)
outliers <- data %>%
  filter(color == "salmon")

# Print the outlier metabolites
print("Outlier metabolites:")
print(outliers)

# Pick 6 outlier metabolites (you can adjust based on your data)
outlier_metabolites <- head(outliers$Metabolite, 6)

# Plot line charts for the 6 outliers
for (metabolite in outlier_metabolites) {
  metabolite_data <- data %>%
    filter(Metabolite == metabolite)

  # Line plot for 0h, 8h, and 24h treatments for WT and Mutant
  plot_data <- data.frame(
    Time = c(0, 8, 24),
    WT = c(metabolite_data$DMSO_WT_0h, metabolite_data$DMSO_WT_8h, metabolite_data$DMSO_WT_24h),
    Mutant = c(metabolite_data$DMSO_Mutant_0h, metabolite_data$DMSO_Mutant_8h, metabolite_data$DMSO_Mutant_24h)
  )

  ggplot(plot_data, aes(x = Time)) +
    geom_line(aes(y = WT, color = "Wild Type"), size = 1) +
    geom_line(aes(y = Mutant, color = "Mutant"), size = 1) +
    labs(title = paste("Metabolic Response for", metabolite),
         x = "Time (hours)", y = "Metabolic Response") +
    scale_color_manual(values = c("Wild Type" = "blue", "Mutant" = "red")) +
    theme_minimal() +
    theme(legend.title = element_blank())
}


