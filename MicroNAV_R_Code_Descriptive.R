#Table 1 - Data descriptor MicroNAV# 
library(readr)
library(readr)
library(tableone)

# Load the MicroNAV clinical dataset.
# Download the corresponding CSV file from PhysioNet:
# https://doi.org/10.13026/rtc6-cq72
#
# Place the file in a local folder named "data".
# Update the filename below to match the downloaded file.

data_path <- file.path("data", "MicroNAV_clinical_data.csv")

if (!file.exists(data_path)) {
  stop("Dataset not found. Download the clinical CSV from PhysioNet.")
}

data_microNAV <- read_csv(data_path, show_col_types = FALSE)
View(data_microNAV)

# Convertir las variables categóricas en factores
data_microNAV$gender <- factor(data_microNAV$gender)
data_microNAV$follow_up_72h <- factor(data_microNAV$follow_up_72h)
data_microNAV$followup_day_5 <- factor(data_microNAV$followup_day_5)
data_microNAV$followup_day7 <- factor(data_microNAV$followup_day7)
data_microNAV$vap <- factor(data_microNAV$vap)
data_microNAV$previous_infection <- factor(data_microNAV$previous_infection)
data_microNAV$died_icu <- factor(data_microNAV$died_icu)
data_microNAV$died_hosp <- factor(data_microNAV$died_hosp)
data_microNAV$`2nd_infec` <- factor(data_microNAV$`2nd_infec`)
data_microNAV$history_of_mdrd <- factor(data_microNAV$history_of_mdrd)

str(data_microNAV)



library(tableone)  # Load the 'tableone' library for creating descriptive statistics tables

# Define the variables of interest
myVars <- c("age", "bmi", "gender", "antibiotics_12months", "smoking_history", "samples_24h", "follow_up_72h", "followup_day_5", "followup_day7"
            , "previous_infection", "died_icu", "died_hosp","2nd_infec")


# Define the categorical variables
catVars <- c("gender", "antibiotics_12months", "smoking_history", "samples_24h", "follow_up_72h", "followup_day_5", "followup_day7", "previous_infection",
             "died_icu", "died_hosp", "2nd_infec")

# Define the variables for which median values should be displayed
med_vars <- c("age", "bmi")


# Create descriptive statistics stratified by
# ventilator-associated pneumonia (VAP) status.
tab1 <- CreateTableOne(vars = myVars,
                       strata = "vap",
                       data = data_microNAV,
                       factorVars = catVars)
tab_all <- CreateTableOne(vars = myVars,
                          data = data_microNAV,
                          factorVars = catVars)


# Imprimir la tabla general
print(tab_all,
      nonnormal = med_vars,
      formatOptions = list(big.mark = ","),
      test = FALSE)

# Imprimir la tabla estratificada
print(tab1,
      nonnormal = med_vars,
      formatOptions = list(big.mark = ","),
      test = TRUE)
