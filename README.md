# MicroNAV: Clinical and microbiological data from mechanically ventilated ICU patients

## Overview

MicroNAV is a dataset derived from a prospective observational cohort of 141 adult patients requiring mechanical ventilation in an intensive care unit in Chía, Colombia. Of these patients, 47 developed ventilator-associated pneumonia (VAP).

The dataset includes clinical, microbiological, immunological, and biochemical information collected at predefined time points during hospitalization.

The objective of sharing this resource is to support reproducible research and secondary analyses investigating ventilator-associated pneumonia, respiratory microbiome composition, inflammatory responses, and clinical outcomes in critically ill patients.

## Dataset availability

The MicroNAV dataset is deposited in PhysioNet.

**Dataset version:** 1.1.1

**DOI:** https://doi.org/10.13026/rtc6-cq72

The PhysioNet repository is the authoritative source for the published dataset. Users should consult the dataset documentation, data dictionary, and access requirements before downloading or analyzing the data.

Some files may require credentialed access under PhysioNet's data use requirements.

## Dataset description

The dataset includes information on 141 adult patients, with 845 variables documented across multiple clinical and follow-up assessments.

Data collection time points include:

- Baseline
- 72 hours
- Day 5
- Day 7
- VAP diagnosis, when applicable
- Extubation
- Hospital discharge
- Secondary infection assessments

The dataset contains clinical and laboratory measurements, microbiological information derived from respiratory samples, inflammatory markers, and clinical outcomes.

Detailed variable definitions and file descriptions are available through PhysioNet.

## Repository contents

This GitHub repository provides supporting documentation and R code associated with the MicroNAV Data Descriptor.

| File | Description |
|---|---|
| `MicroNAV_R_Code_Descriptive.R` | R script for generating descriptive statistics for Table 1, including comparisons according to VAP status. |
| `MicroNAV_Metadata_XLM` | Study metadata file. |
| `README.md` | Documentation describing the dataset, repository contents, and available code. |

The publicly available R script focuses on descriptive statistical analyses. This repository should not be interpreted as containing the complete laboratory or bioinformatics processing pipelines unless additional scripts are deposited.

## Requirements

The descriptive R script uses the following packages:

- `readr`
- `tableone`

## Reproducing the descriptive analysis

1. Obtain the relevant clinical dataset from PhysioNet version 1.1.1.
2. Review the data dictionary and confirm that the required variables are available.
3. Download the R script from this repository.
4. Install the required R packages.
5. Configure the input file path according to the instructions in the script.
6. Execute the script to generate descriptive statistics.

The script generates overall and VAP-stratified descriptive summaries.

Users should verify the coding of categorical variables, missing values, and statistical testing assumptions before interpreting the results.

## Data documentation and reproducibility

The published PhysioNet dataset should be used as the primary source of data.

The GitHub repository provides supplementary code and documentation. Availability of descriptive analysis code does not imply that all procedures used for microbiological sequencing, immunological assays, biochemical processing, or original dataset construction are reproducible from the files currently deposited here.

## Citation

If you use the MicroNAV dataset, please cite the version-specific PhysioNet record:

https://doi.org/10.13026/rtc6-cq72

Please also cite the associated *Scientific Data* Data Descriptor once published.

## Contact

MicroNAV is maintained by the Translational Science in Infectious Diseases and Critical Care Medicine research team (TS-ID-CCM).

For questions regarding the dataset or supporting code, please contact:

nataliasahe@unisabana.edu.co
