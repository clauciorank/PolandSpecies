data <- read.csv('../data/polandProvinces.csv')
library(dplyr)


n_per_specie <-
data |>
    group_by(scientificVernacular) |>
    summarise(n = dplyr::n()) |>
    ungroup() |>
    arrange(n)


set.seed(12)

min <- n_per_specie |> filter(n == min(n))
max <- n_per_specie |> filter(n == max(n))


random_sample <- sample(n_per_specie$scientificVernacular, 3)
min_sample <- sample(min$scientificVernacular, 1)
max_sample <- max$scientificVernacular

inputs_to_test <- c(random_sample, min_sample, max_sample)
inputs_to_test

