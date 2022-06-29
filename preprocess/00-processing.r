library(dplyr)
library(disk.frame)


# Transforming to a readable file since the unread csv have +20GB and
# excceded my RAM memory

csv_to_disk.frame(infile = 'occurence.csv',
                outdir = 'df', backend = 'readr',
                in_chunk_size = 1000000)



all_df <- disk.frame::disk.frame('~/Documents/biodiversity-data/df')
names(all_df)

# Filter only Poland data
poland <- all_df |> select(scientificName, taxonRank, kingdom, family, vernacularName, longitudeDecimal, latitudeDecimal, eventDate, country, locality, stateProvince) |>
            filter(country == 'Poland') |> collect()


write.csv(poland, '~/Documents/biodiversity-data/poland.csv')

