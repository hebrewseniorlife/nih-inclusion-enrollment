# creates example data

set.seed("1701")

n_ppts <- sample.int(500, 1)

race_ethn_data <- data.frame(
  studyid = c(1:n_ppts),
  sex = sample(c(1, 2, NA_integer_), n_ppts, replace = TRUE),
  hispaniceth = sample(
    c(0 , 1, NA_integer_),
    prob = c(.65, .28, .07),
    n_ppts,
    replace = TRUE
    ),
  race_code = sample(
    c("A", "B", "M", "N", "P", "U", "W", NA_character_),
    prob = c(.15, .20, .03, .02, .02, .03, .55, .02),
    n_ppts,
    replace = TRUE
    ), 
  dob = sample(
    seq(as.Date('1950/01/01'), as.Date('1985/01/01'), by="day"),
    n_ppts),
  date_enrolled = 
    sample(
      seq(Sys.Date() - years(1), Sys.Date(), by="day"),
      n_ppts)
)