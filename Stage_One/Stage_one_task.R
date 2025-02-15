# LInks to Github profiles of teams members:
#Rebecca Batoh: https://github.com/rbatoh/Hackbio-biocoding-internship.git
#Emmanuel Oluwarotimi Igiehon: https://github.com/Rotimi626/
#Ajayi Grace: https://github.com/Torren11/Hackbio-biocoding-internship.git
#Olajide Temitope: https://github.com/TemitopeOlajide1/

# Links to LinkedIn profiles of team members: 
#Rebecca Batoh: https://www.linkedin.com/in/rebecca-batoh/
#Emmanuel Oluwarotimi Igiehon: https://www.linkedin.com/in/emma-igiehon-300a2a260/
#Ajayi Grace: https://www.linkedin.com/in/graceoluwasola/
#Olajide Temitope: https://www.linkedin.com/in/temitope-esther-olajide/


#Function to Translate DNA to Protein
translate_DNA_to_protein <- function(dna_sequence) {
  # Define the codon to amino acid mapping
  codon_table <- c(
    "ATA"="I", "ATC"="I", "ATT"="I", "ATG"="M", "ACA"="T", "ACC"="T", 
    "ACG"="T", "ACT"="T", "AAC"="N", "AAT"="N", "AAA"="K", "AAG"="K", 
    "ACA"="T", "ACC"="T", "ACG"="T", "ACT"="T", "CTA"="L", "CTC"="L", 
    "CTG"="L", "CTT"="L", "CCA"="P", "CCC"="P", "CCG"="P", "CCT"="P", 
    "GCA"="A", "GCC"="A", "GCG"="A", "GCT"="A", "GGA"="G", "GGC"="G", 
    "GGG"="G", "GGT"="G", "TCA"="S", "TCC"="S", "TCG"="S", "TCT"="S", 
    "TTC"="F", "TTT"="F", "TTA"="L", "TTG"="L", "TAC"="Y", "TAT"="Y", 
    "TAA"="*", "TAG"="*", "TGC"="C", "TGT"="C", "TGA"="*", "TGG"="W", 
    "CTA"="L", "CTC"="L", "CTG"="L", "CTT"="L", "CCA"="P", "CCC"="P",
    "GGA"="G", "GGG"="G", "GGC"="G", "GGT"="G"
  )
  # Split the DNA sequence into 3-letter codons
  codons <- substring(dna_sequence, seq(1, nchar(dna_sequence), by=3),
                   seq(3, nchar(dna_sequence), by=3))
  
  # Translate the codons into amino acids
  protein <- sapply(codons, function(codon) codon_table[codon])
  
  # Return the protein sequence as a string
  return(paste(protein, collapse=""))
}
#Example:
dna_sequence <- "ATGGCCATTGTAATGGGCCGCTGAAAGGGT"
protein_sequence <- translate_DNA_to_protein(dna_sequence)
print(protein_sequence)


# Logistic Population Growth Function
logistic_growth_curve <- function(t, K, r, lag_phase, exp_phase) {
  #Randomizing the lag and exponential phase times
  time_to_lag <- sample(0:lag_phase, 1)
  time_to_exp <- sample(0:exp_phase, 1)
  
  # Population model
  population <- K / (1 + exp(-r * (t - time_to_lag - time_to_exp)))
  return(population)
}

# Function to generate 100 growth curves
growth_curves <- function(num_curves = 100, K = 1000, r = 0.1, lag_phase = 20, exp_phase = 30, t_max = 100) {
  time_points <- seq(0, t_max, length.out = 100)  
  curves <- data.frame(matrix(ncol = 100, nrow = num_curves))  
  for (i in 1:num_curves) {
    curves[i, ] <- logistic_growth_curve(time_points, K, r, lag_phase, exp_phase)
    }
    return(curves)
  }
  
  # Example: Plot growth curves
  growth_data <- growth_curves(num_curves = 100, K = 1000, r = 0.1, lag_phase = 20, exp_phase = 30, t_max = 100)
  plot(1:100, growth_data$V1, type = "l", col = "blue", xlab = "Time", ylab = "Population Size")  
  
  # Time to Reach 80% of Maximum Growth
  time_to_reach_80 <- function(K, r, lag_phase, exp_phase, time_points) {
    logistic_func <- function(t) {
      return(K / (1 + exp(-r * (t - lag_phase - exp_phase)))) 
    }
    threshold <- 0.8 * K  
    for (t in time_points) {
      if (logistic_func(t) >= threshold) {
        return(t)  
      }
    }
    return(NA)  
  }
  
  # Example: Calculate time to reach 80% of max population
  time_points <- seq(0, 100, by = 1)
  time_to_80 <- time_to_reach_80(K = 1000, r = 0.1, lag_phase = 20, exp_phase = 30, time_points = time_points)
  print(time_to_80)

# Calculate Hamming Distance
  hamming_distance <- function(string1, string2) {
    # Pad the shorter string with spaces (if necessary)
    max_len <- max(nchar(string1), nchar(string2))
    string1 <- paste0(string1, strrep(" ", max_len - nchar(string1)))
    string2 <- paste0(string2, strrep(" ", max_len - nchar(string2)))
    
    # Calculate Hamming distance
    dist <- sum(strsplit(string1, NULL)[[1]] != strsplit(string2, NULL)[[1]])
    
    return(dist)
  }
  #example: 
hamming_distance("grace", "gracy_ldn")
  
  
