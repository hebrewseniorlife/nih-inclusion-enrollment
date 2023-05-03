# NIH Inclusion Enrollment Report
This repository contains scripts and an rmarkdown report to demonstrate how to 
create an inclusion enrollment reporting table and dataset per [NIH
specifications](https://www.era.nih.gov/erahelp/assist/Content/ASSIST_Help_Topics/3_Form_Screens/PHS_HS_CT/Incl_Enroll_Rprt.htm)

## Report - `NIH Inclusion Enrollment Report.Rmd`
This is an rmarkdown report using the `distill` template that outputs the NIH specified enrollment table and provides a download capacity to download the NIH formatted dataset as CSV for upload to the NIH portal.

It uses the scripts below to format age, sex, race, and ethnicity data to NIH specifications and present the data as a table or CSV download.

## Scripts
`create_example.R` - creates example data of necessary variables using randomly generated numbers

`create_dataset.R` - formats dataset from the above script to NIH specifications for table output and creates a dataset for output to CSV to NIH specs

`create_table.R` - creates a nested table per NIH specs

## Dependencies
This code uses the following R packages: `tidyverse`, `lubridate`, `gt`, `gtsummary`, `downloadthis`, and `rmarkdown`/`knitr`.

In order to produce the inclusion enrollment table and dataset, you will need the following:

- Age
    - must be evaluable to units of years
- Race
    - must be evaluable to the categories listed in the NIH specs
- Ethnicity
    - must be evaluable to the categories listed in the NIH specs
- Gender
    - must be evaluable to Male, Female or Unknown/Not Reported
- Enrollment date
    - or date associated with the participant record that will be used to determine if the participant will be reported
- Inclusion date
    - date against which the above enrollment date will be tested to determine if a participant will be included in the report

## How to use this repository
1. Install the above dependencies using `install.packages(c("tidyverse", "lubridate", "gt", "gtsummary", "downloadthis"))` if necessary
2. Knit `NIH Inclusion Enrollment Report.Rmd`


If you wish to look at individual components of the report:

1. Run `create_example.R` to create the example dataset.
2. Run `create_dataset.R` to format the dataset for output and create the CSV output dataset
3. Run `create_table.R` to create the output table.
