# Bioinformatics Analysis Repository

## Project Overview

This repository contains solutions for multiple bioinformatics tasks related to Microbiology, Botany, Biochemistry, Oncology, and Public Health. The project involves analyzing various datasets and performing statistical and visual analysis on different biological phenomena, such as gene mutations, metabolic responses, protein structure-function relationships, and health assessments.

The tasks are organized into separate sections, each focused on a different biological domain. This README provides an overview of each task, instructions on how to run the code, and what to expect in the analysis.

---

## Table of Contents

1. [Microbiology: Task Code 2.1](#microbiology-task-code-21)
2. [Botany and Plant Science: Task Code 2.3](#botany-and-plant-science-task-code-23)
3. [Biochemistry & Oncology: Task Code 2.4](#biochemistry--oncology-task-code-24)
4. [Public Health: NHANES](#public-health-nhanes)
5. [Requirements](#requirements)
6. [Usage](#usage)

---

## Microbiology: Task Code 2.1

In this task, we are given a dataset related to the growth of different strains of bacteria. The task involves:

- Plotting growth curves (OD600 vs. Time) for each strain and its mutants (knockout and knock-in strains) overlaid.
- Determining the time it takes for each strain to reach its carrying capacity.
- Generating scatter and box plots comparing the time to reach carrying capacity for the knockout and knock-in strains.
- Performing a statistical analysis to determine if there is a significant difference in the time to reach carrying capacity.

---

## Botany and Plant Science: Task Code 2.3

This task involves metabolic response analysis in engineered mutant plants and their comparison with wild-type plants. Specifically, the task requires:

- Calculating the difference in metabolic response (ΔM) between DMSO treatment and 24-hour treatment for wild-type and mutant plants.
- Generating a scatter plot of the ΔM for both wild-type and mutant plants, fitting a line with a y-intercept of 0 and a slope of 1.
- Identifying metabolites with residuals outside of a given cutoff range and highlighting them in the plot.
- Generating line plots for selected metabolites and analyzing their trends over time.

---

## Biochemistry & Oncology: Task Code 2.4

This task deals with understanding the impact of individual non-synonymous nonsense mutations on protein structure and function. The task includes:

- Merging two datasets (SIFT and FoldX scores) based on a common column (specific_Protein_aa) to evaluate the effects of mutations on protein function and structure.
- Identifying mutations that are both deleterious to function (SIFT < 0.05) and structure (FoldX > 2).
- Analyzing the frequency of amino acid substitutions and visualizing them using bar plots and pie charts.
- Investigating amino acids with the most functional and structural impact and providing conclusions based on the analysis.

---

## Public Health: NHANES

In this task, we process data from the National Health and Nutrition Examination Survey (NHANES). The objective is to:

- Process missing data (NA values) by either deleting or converting them to zero.
- Visualize the distribution of various health metrics such as BMI, Weight, and Age using histograms.
- Calculate and visualize various statistical metrics, including mean, range, variance, and standard deviation for different health variables.
- Conduct t-tests to analyze relationships between age, gender, BMI, diabetes, and alcohol consumption.

---

## Requirements

- R
- `ggplot2`
- `dyrl`

You can install the required libraries from `Rstudio`


