# Respiratory Microbiome and Ventilator-Associated Pneumonia (VAP) Dataset Repository

## Overview

Welcome to the repository housing the dataset and associated code for the study on the respiratory microbiome and its role in Ventilator-Associated Pneumonia (VAP). This prospective observational study was conducted in an Intensive Care Unit (ICU) in Chía, Colombia, and involved 141 adult patients requiring mechanical ventilation. The dataset provides a comprehensive collection of clinical data, microbiome analysis, and inflammatory marker quantifications, offering valuable insights into the microbial ecology of VAP and its relationship with immune dysregulation.

## Dataset Description

The dataset, available on Physionet, includes 845 variables collected across multiple structured time points:

- Baseline (within 24 hours of ICU admission)
- 72 hours
- Day 5
- Day 7
- At VAP diagnosis (if applicable)
- Post-extubation
- At hospital discharge
- Secondary infections during admission or after extubation

**Classes of Data**

- Clinical & Paraclinical Variables: Vital signs, laboratory results, comorbidities, treatments, antibiotic exposure, severity scores, outcomes.
- Respiratory Microbiome: Operational Taxonomic Units (OTUs) identified via 16S rRNA sequencing, linked to patient IDs.
- Inflammatory Markers: Pulmonary and systemic cytokines quantified via ELISA.
- Outcome Variables: VAP occurrence, mortality, secondary infections, extubation, discharge metrics.

A full data dictionary and variable descriptions are available on Physionet.

## Repository Structure

This repository is organized to provide easy access to the dataset and the tools necessary for its analysis:

R Code: Contains scripts and notebooks demonstrating how to perform descriptive statistics and microbiome analysis on the dataset. These resources are designed to help users understand the dataset structure, access data points, and start their analysis.
Dataset Documentation: Provides detailed descriptions of the variables, the data collection process, and the methods used in microbiome analysis and inflammatory marker quantification.
Getting Started

To begin working with the dataset and code in this repository, follow these steps:

Familiarize Yourself with the Dataset:
Review the dataset documentation to understand the structure, types of data included, and the scope of the study.
Explore the R Code:
Use the provided R scripts and notebooks to reproduce the tables used in the data descriptor. These resources will guide you through data manipulation, performing descriptive statistics, interpreting key findings, and prepare the analytical-ready dataset for future statistical modelling and machine learning
Engage with the Research Community:
If you have questions, suggestions, or contributions, feel free to reach out. Collaborative efforts are crucial for advancing research in respiratory microbiology and improving ICU outcomes.

Acknowledgement
If you use MicroNAV data or code, please cite the dataset and the associated data descriptor. Attribution supports open science and the continued development of translational research resources.

## License

This repository is licensed under the MIT License, allowing you the freedom to use, modify, and distribute the software, provided that the license and copyright notice are included with any substantial portions of the software. For more details, please refer to the LICENSE file in this repository.

## Conclusion

Thank you for your interest in the Respiratory Microbiome and VAP Dataset Repository. We are excited to see how this resource contributes to the understanding and treatment of Ventilator-Associated Pneumonia and related conditions in critically ill patients.
