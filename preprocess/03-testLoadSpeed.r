## Test to decide what reading method will be used for better performance

csv <- 'polandProvinces.csv'

readr <- system.time(
    readr::read_csv(csv)
)


fread <- system.time(
    data.table::fread(csv)
)


#TO RDS
saveRDS(read.csv(csv), 'polandProvinces.Rds')


rds <- system.time(
    readRDS('polandProvinces.Rds')
)



# readr
# fread
# rds
#    user  system elapsed
#   0.161   0.000   0.161
#    user  system elapsed
#   0.082   0.000   0.049
#    user  system elapsed
#   0.123   0.000   0.122

# fread is better
