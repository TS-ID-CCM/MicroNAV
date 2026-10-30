# MicroNAV Data Descriptor — reproducible descriptive Table 1
# Dataset: PhysioNet MicroNAV v1.1.1 (https://doi.org/10.13026/rtc6-cq72)
# Analysis environment: R 4.3.3; tableone 0.13.2
# This script NEVER overwrites or edits the deposited dataset.
#
# Usage:
#   1. Download MicroNAV_Dataset.csv from PhysioNet v1.1.1.
#   2. Put it in the working directory, or change input_file below.
#   3. Run the entire script in RStudio.
#   4. Review console output and MicroNAV_Table1_recalculated.csv.
#
# IMPORTANT CODING NOTES:
#   - In PhysioNet v1.1.1, VAP cases are coded 1 and non-VAP cases
#     are represented by NA. The original local analysis file used 0/1.
#     We derive a temporary binary grouping variable, after checks.
#   - For participants discharged alive (disch_alive == 1), died_icu
#     and died_hosp are structurally NA. For this table only, they are
#     coded as absence of the respective event (0). No other NA is filled.
#   - The two death indicators overlap for one patient. They are NOT
#     mutually exclusive categories and should not be summed.
#   - These coding interpretations should be cross-checked with the
#     study data dictionary/protocol before manuscript submission.

# ---- 1. Packages ------------------------------------------------------------
required <- c("readr", "tableone")
missing_packages <- required[!vapply(required, requireNamespace,
                                      logical(1), quietly = TRUE)]
if (length(missing_packages)) {
  stop("Install required packages: ", paste(missing_packages, collapse = ", "))
}

# ---- 2. Read the deposited clinical dataset --------------------------------
input_file <- "MicroNAV_Dataset.csv"
if (!file.exists(input_file)) stop("File not found: ", input_file)
raw <- readr::read_csv(input_file, show_col_types = FALSE)

required_vars <- c(
  "age", "bmi", "gender", "vap", "follow_up_72h", "followup_day_5",
  "followup_day7", "died_icu", "died_hosp", "disch_alive", "2nd_infec"
)
if (!all(required_vars %in% names(raw))) {
  stop("Missing columns: ", paste(setdiff(required_vars, names(raw)), collapse = ", "))
}
if (nrow(raw) != 141L) {
  stop("Expected 141 patients in v1.1.1; found ", nrow(raw), ". Check input file.")
}

# ---- 3. Validate outcome coding; derive analysis-only variables ------------
# PhysioNet VAP field: 1 = VAP; NA = no VAP (verify with dictionary).
if (!all(is.na(raw$vap) | raw$vap == 1)) {
  stop("Unexpected VAP coding. Inspect the dictionary before continuing.")
}
vap_group <- ifelse(is.na(raw$vap), 0L, 1L)
if (!identical(as.integer(table(factor(vap_group, levels = 0:1))),
               c(94L, 47L))) {
  stop("Unexpected VAP group sizes; do not proceed without investigation.")
}

# Confirm the structural NA pattern before temporary recoding.
alive <- !is.na(raw$disch_alive) & raw$disch_alive == 1
na_both <- is.na(raw$died_icu) & is.na(raw$died_hosp)
if (!identical(which(alive), which(na_both)) || sum(alive) != 100L ||
    anyNA(raw$disch_alive) ||
    any(!(raw$disch_alive %in% c(0, 1)))) {
  stop("Mortality missingness pattern differs from the verified cohort.")
}
if (anyNA(raw$died_icu[!alive]) || anyNA(raw$died_hosp[!alive])) {
  stop("Missing death indicators among patients not discharged alive.")
}

# Work only on a separate in-memory copy; preserve raw and the source CSV.
dat <- raw
dat$vap_group <- factor(vap_group, levels = 0:1,
                        labels = c("No VAP", "VAP"))
dat$died_icu_event <- ifelse(alive, 0L, as.integer(raw$died_icu))
dat$died_hosp_event <- ifelse(alive, 0L, as.integer(raw$died_hosp))

# Factor variables: 0/1 with 1 as the displayed event level.
cat_vars <- c("gender", "follow_up_72h", "followup_day_5",
              "followup_day7", "died_icu_event", "died_hosp_event",
              "2nd_infec")
for (nm in cat_vars) {
  x <- dat[[nm]]
  if (!all(is.na(x) | x %in% c(0, 1))) {
    stop("Unexpected binary coding in: ", nm)
  }
  dat[[nm]] <- factor(x, levels = 0:1)
}

# ---- 4. Generate Table 1 ----------------------------------------------------
# Use Pearson chi-squared tests as in the original tableone workflow,
# Kruskal-Wallis for age/BMI, and Fisher exact for the two death indicators.
vars <- c("age", "bmi", "gender", "follow_up_72h", "followup_day_5",
          "followup_day7", "died_icu_event", "died_hosp_event", "2nd_infec")
non_normal <- c("age", "bmi")
exact_vars <- c("died_icu_event", "died_hosp_event")

tab_overall <- tableone::CreateTableOne(
  vars = vars, data = dat, factorVars = cat_vars, includeNA = FALSE
)
tab_by_vap <- tableone::CreateTableOne(
  vars = vars, strata = "vap_group", data = dat,
  factorVars = cat_vars, includeNA = FALSE
)

cat("\n=== Overall cohort ===\n")
print(tab_overall, nonnormal = non_normal, test = FALSE,
      formatOptions = list(big.mark = ","))
cat("\n=== By VAP status: Fisher exact for mortality ===\n")
print(tab_by_vap, nonnormal = non_normal, exact = exact_vars,
      test = TRUE, formatOptions = list(big.mark = ","))

# ---- 5. Save a formatted, manuscript-oriented CSV ---------------------------
# Capture the same tableone formatting used in the console output.
overall_matrix <- print(tab_overall, nonnormal = non_normal,
                        test = FALSE, printToggle = FALSE, noSpaces = TRUE)
strat_matrix <- print(tab_by_vap, nonnormal = non_normal,
                      exact = exact_vars, test = TRUE,
                      printToggle = FALSE, noSpaces = TRUE)

# Match rows by their variable prefix, including displayed factor level.
row_for <- function(mat, variable) {
  idx <- which(rownames(mat) == variable |
                 startsWith(rownames(mat), paste0(variable, " =")) |
                 startsWith(rownames(mat), paste0(variable, " (")))
  if (length(idx) != 1L) {
    stop("Expected exactly one row for ", variable,
         "; found ", length(idx), ". Inspect tableone output.")
  }
  idx
}

labels <- c(
  "Age, median [IQR]", "BMI, median [IQR]", "Male sex, n (%)",
  "Follow-up at 72 hours, n (%)", "Follow-up at day 5, n (%)",
  "Follow-up at day 7, n (%)", "Died in ICU, n (%)",
  "Died during general hospitalization, n (%)", "Secondary infection, n (%)"
)

output <- data.frame(
  Characteristic = labels,
  Overall = character(length(vars)),
  No_VAP = character(length(vars)),
  VAP = character(length(vars)),
  p_value = character(length(vars)),
  stringsAsFactors = FALSE,
  check.names = FALSE
)

# tableone has columns 'Overall' for unstratified and group names for
# stratified output; identify these by position to avoid name changes.
for (i in seq_along(vars)) {
  oi <- row_for(overall_matrix, vars[i])
  si <- row_for(strat_matrix, vars[i])
  output$Overall[i] <- overall_matrix[oi, 1]
  output$No_VAP[i] <- strat_matrix[si, 1]
  output$VAP[i] <- strat_matrix[si, 2]
  output$p_value[i] <- strat_matrix[si, "p"]
}

names(output)[2:4] <- c("Overall (n=141)", "No VAP (n=94)", "VAP (n=47)")
readr::write_csv(output, "MicroNAV_Table1_recalculated.csv", na = "")
cat("\nSaved: MicroNAV_Table1_recalculated.csv\n")

# ---- 6. Reproducibility and validation checks -------------------------------
cat("\nMortality cross-tabulations (0 = no event, 1 = event):\n")
print(table(dat$vap_group, dat$died_icu_event))
print(table(dat$vap_group, dat$died_hosp_event))
cat("\nFisher exact tests for mortality:\n")
print(fisher.test(table(dat$vap_group, dat$died_icu_event)))
print(fisher.test(table(dat$vap_group, dat$died_hosp_event)))
cat("\nNumber with both mortality flags = 1: ",
    sum(dat$died_icu_event == 1 & dat$died_hosp_event == 1), "\n", sep = "")
cat("\nR version: ", R.version.string, "\n", sep = "")
cat("tableone version: ", as.character(packageVersion("tableone")), "\n", sep = "")
cat("\nNOTE: Inspect exported results before replacing the manuscript table.\n")
