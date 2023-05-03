# create formatted dataset

source("create_example.R")

library(tidyverse)

# set an anchor date to calculate age
anchor.date <- Sys.Date()

# set a cutoff date for data
cutoff <- Sys.Date() - months(1)

# filter data by cutoff date and label variables, calculate age in years
race_db <- race_ethn_data %>%
  filter(date_enrolled <= cutoff) %>% 
  mutate(
    gender = case_when(
      sex == 1 ~ "Male",
      sex == 2 ~ "Female",
      is.na(sex) ~ "Unknown or Not Reported"
    ),
    ethnicity = case_when(
      hispaniceth == 1 ~ "Hispanic or Latino",
      hispaniceth == 0 ~ "Not Hispanic or Latino",
      is.na(hispaniceth) ~ "Unknown/Not Reported Ethnicity"
    ),
    race = case_when(
      race_code == "A" ~ "Asian",
      race_code == "B" ~ "Black",
      race_code == "M" ~ "More than One Race",
      race_code == "N" ~ "American Indian or Alaskan Native",
      race_code == "P" ~ "Native Hawaiian or Pacific Islander",
      race_code == "U" | is.na(race_code) ~ "Unknown or Not Reported",
      race_code == "W" ~ "White"
    ),
    age = as.integer((Sys.Date() - dob) / 365.24)
  )

# format for reporting output
reporting_db <- race_db %>% 
  mutate(
    age_units = case_when(
      age < 90 ~ "Years",
      age >= 90 ~ "Ninety Plus",
      is.na(age) ~ "Unknown"
    ),
    age = case_when(
      age < 90 ~ age,
      age >= 90 ~ NA_real_
    ),
    race = factor(
      race,
      levels = c(
        "American Indian or Alaskan Native",
        "Asian",
        "Native Hawaiian or Pacific Islander",
        "Black",
        "White",
        "More than One Race",
        "Unknown or Not Reported"
      )
    ),
    gender = factor(
      gender,
      levels = c("Female", "Male", "Unknown or Not Reported")
    )
  ) %>% 
  select(studyid, ethnicity, race, gender, age, age_units)

# format for CSV output
output_db <- reporting_db %>% 
  mutate(
    across(c(race, ethnicity, gender), as.character),
    race = case_when(
      race == "Asian Indian or Pacific Islander" ~ "Asian",
      race == "American Indian or Alaskan Native" ~ "American Indian",
      race == "Unknown or Not Reported" ~ "Unknown",
      race == "More than One Race" ~ "More than one race",
      TRUE ~ race
    ),
    ethnicity = case_when(
      ethnicity == "Unknown/Not Reported Ethnicity" ~ "Unknown",
      TRUE ~ ethnicity
    ),
    gender = case_when(
      gender == "Unknown or Not Reported" ~ "Unknown",
      TRUE ~ gender
    )
  ) %>% 
  select(
    Race = race, Ethnicity = ethnicity, Gender = gender, Age = age,
    "Age Unit" = age_units
  ) %>% 
  mutate(
    Age = as.character(Age),
    across(everything(), replace_na, "")
  )