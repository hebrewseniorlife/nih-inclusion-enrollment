# create reporting table

source("create_dataset.R")

library(gt)
library(gtsummary)

# if there are no participants with unknown/not reported ethnicity, create a 
# dummy table
# non hispanic participants
if (reporting_db %>% 
    filter(ethnicity == "Unknown/Not Reported Ethnicity") %>% 
    nrow() == 0) {
  nh_tab <- reporting_db %>% 
    filter(ethnicity == "Unknown/Not Reported Ethnicity") %>% 
    select(race, gender) %>%
    complete(race, gender) %>% 
    tbl_cross(row = race, col = gender, 
              margin = "row",
              label = list(race ~ "Racial Categories")) %>%
    modify_table_body(
      ~ .x %>%
        mutate(
          stat_1 = c(NA, rep(0, nrow(.x) - 1)),
          stat_2 = c(NA, rep(0, nrow(.x) - 1)),
          stat_3 = c(NA, rep(0, nrow(.x) - 1))
        )
    )
# otherwise produce a table as normal
} else {
nh_tab <- reporting_db %>% 
  filter(ethnicity == "Not Hispanic or Latino") %>% 
  select(race, gender) %>%  
  tbl_cross(row = race, col = gender, 
            margin = "row",
            label = list(race ~ "Racial Categories"))
}

# repeat for hispanic ppts
if (reporting_db %>% 
    filter(ethnicity == "Unknown/Not Reported Ethnicity") %>% 
    nrow() == 0) {
  hisp_tab <- reporting_db %>% 
    filter(ethnicity == "Unknown/Not Reported Ethnicity") %>% 
    select(race, gender) %>%
    complete(race, gender) %>% 
    tbl_cross(row = race, col = gender, 
              margin = "row",
              label = list(race ~ "Racial Categories")) %>%
    modify_table_body(
      ~ .x %>%
        mutate(
          stat_1 = c(NA, rep(0, nrow(.x) - 1)),
          stat_2 = c(NA, rep(0, nrow(.x) - 1)),
          stat_3 = c(NA, rep(0, nrow(.x) - 1))
        )
    )
} else {
hisp_tab <- reporting_db %>% 
  filter(ethnicity == "Hispanic or Latino") %>% 
  select(race, gender)  %>% 
  tbl_cross(row = race, col = gender, 
            margin = "row",
            label = list(race ~ "Racial Categories"))
}

# repeat for ppts with unknown ethnicity
if (reporting_db %>% 
    filter(ethnicity == "Unknown/Not Reported Ethnicity") %>% 
    nrow() == 0) {
  unk_tab <- reporting_db %>% 
    filter(ethnicity == "Unknown/Not Reported Ethnicity") %>% 
    select(race, gender) %>%
    complete(race, gender) %>% 
    tbl_cross(row = race, col = gender, 
              margin = "row",
              label = list(race ~ "Racial Categories")) %>%
    modify_table_body(
      ~ .x %>%
        mutate(
          stat_1 = c(NA, rep(0, nrow(.x) - 1)),
          stat_2 = c(NA, rep(0, nrow(.x) - 1)),
          stat_3 = c(NA, rep(0, nrow(.x) - 1))
        )
    )
} else {
  unk_tab <- reporting_db %>% 
    filter(ethnicity == "Unknown/Not Reported Ethnicity") %>% 
    select(race, gender) %>% 
    tbl_cross(row = race, col = gender, 
              margin = "row",
              label = list(race ~ "Racial Categories"))
}

# merge the three tables
incl_enrollment_tab <- tbl_merge(
  tbls = list(nh_tab, hisp_tab, unk_tab),
  tab_spanner = c("Not Hispanic or Latino",
                  "Hispanic or Latino",
                  "Unknown/Not Reported Ethnicity")
)