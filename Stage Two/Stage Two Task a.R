# Task Code 2.4: Biochemistry & Oncology Merging datasets and analyzing the mutation impact
# Load necessary libraries
library(dplyr)
library(ggplot2)

# Load the datasets
url_1 <- "https://raw.githubusercontent.com/HackBio-Internship/public_datasets/main/R/datasets/sift.tsv"
url_2 <- "https://raw.githubusercontent.com/HackBio-Internship/public_datasets/main/R/datasets/foldX.tsv"
sift_data <- read.csv(url_1) 
foldx_data <- read.csv(url_2)

# Inspect the datasets to check the structure
head(sift_data)
head(foldx_data)

# 1. Create a column specific_Protein_aa by concatenating Protein and Amino_acid
sift_data <- sift_data %>%
  mutate(specific_Protein_aa = paste(Protein, Amino_acid, sep = "_"))

foldx_data <- foldx_data %>%
  mutate(specific_Protein_aa = paste(Protein, Amino_acid, sep = "_"))

# 2. Merge the data sets by specific_Protein_aa
merged_data <- merge(sift_data, foldx_data, by = "specific_Protein_aa")

# 3. Find mutations that have a SIFT score below 0.05 and FoldX Score above 2
deleterious_mutations <- merged_data %>%
  filter(SIFT < 0.05 & FoldX > 2)

# Inspect the deleterious mutations
head(deleterious_mutations)

# 4. Investigate the amino acid substitution nomenclature
# Extract the first amino acid from the Amino_acid column
merged_data <- merged_data %>%
  mutate(first_AA = substr(Amino_acid, 1, 1))

# Find the amino acid with the most functional and structural impact
# Count the occurrences of each amino acid
aa_impact <- merged_data %>%
  group_by(first_AA) %>%
  summarise(functional_impact = sum(SIFT < 0.05),
            structural_impact = sum(FoldX > 2)) %>%
  arrange(desc(functional_impact + structural_impact))

# The amino acid with the highest impact
top_impact_aa <- aa_impact[1, ]
print(top_impact_aa)

# 5. Generate a frequency table for all amino acids
aa_frequency <- table(merged_data$first_AA)

# 6. Generate a barplot for amino acid frequencies
ggplot(as.data.frame(aa_frequency), aes(x = Var1, y = Freq)) +
  geom_bar(stat = "identity") +
  labs(title = "Amino Acid Frequency", x = "Amino Acid", y = "Frequency") +
  theme_minimal()

# 7. Generate a pie chart for amino acid frequencies
ggplot(as.data.frame(aa_frequency), aes(x = "", y = Freq, fill = Var1)) +
  geom_bar(stat = "identity", width = 1) + 
  coord_polar(theta = "y") + 
  labs(title = "Amino Acid Frequency Pie Chart") +
  theme_void()

# 8. Investigate amino acids with more than 100 occurrences
frequent_aa <- aa_frequency[aa_frequency > 100]
print(frequent_aa)



