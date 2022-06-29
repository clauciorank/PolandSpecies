library(ggplot2)
library(sf)

# Get provinces


poland <- read.csv('preprocess/poland.csv')


## Read geojson and transform for planar since sf library assumes planar projection
sf <- geojsonsf::geojson_sf('data/poland.geojson', expand_geometries = TRUE)
sf_trans <- st_transform(sf, 2163)

pnts <- data.frame(
"x" = poland$longitudeDecimal,
"y" = poland$latitudeDecimal)

# create a points collection
pnts_sf <- do.call("st_sfc",c(lapply(1:nrow(pnts),function(i){
    st_point(as.numeric(pnts[i, ]))}),
    list("crs" = 4326)))

pnts_trans <- st_transform(pnts_sf, 2163) # apply transformation to pnts sf

# intersect and extract province name
pnts$region <- apply(st_intersects(sf_trans, pnts_trans, sparse = FALSE), 2,
               function(col) {
                  sf_trans[which(col), ]$nazwa
               })

pnts$region <- unlist(lapply(pnts$region, \(x){
    ifelse(length(x)==0, NA, x)
}))

poland <- poland |>
            dplyr::mutate(stateProvince = pnts$region) |> 
            dplyr::filter(!is.na(stateProvince)) |>  # removing 309 na values (0.63%) out of the poland map
            dplyr::filter(!is.na(scientificName) & !is.na(vernacularName)) |> # removing NA names
            dplyr::mutate(scientificVernacular = paste(vernacularName, '-', scientificName)) |>
            dplyr::select(-locality)

write.csv(poland, 'data/polandProvinces.csv')






