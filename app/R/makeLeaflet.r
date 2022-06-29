make_leaflet <- function(map, data){

  ## Setting bins for the map in diferent situation for managing cover edge cases

  if(length(unique(map$n)) >= 7){
    pal <- leaflet::colorQuantile("Blues", domain = unique(map$n), 7)
  }else{
    pal <- leaflet::colorNumeric("Blues", map$n)
  }

  ## Popup labels

  labels <- sprintf(
    "<strong>%s</strong><br/>Observations: %g",
    stringr::str_to_title(map$nazwa), map$n) |> lapply(htmltools::HTML)

  # Generate Plot
  leaflet(map, options = leafletOptions(zoomControl = FALSE)) |>
    addProviderTiles(providers$Stamen.TonerLite,
      options = providerTileOptions(noWrap = TRUE)) |>
    addPolygons(fillColor = ~pal(n),
                weight = 2,
                opacity = 1,
                color = "black",
                dashArray = "3",
                fillOpacity = 0.7,
                highlightOptions = highlightOptions(
                  weight = 5,
                  color = "#666",
                  dashArray = "",
                  fillOpacity = 0.8,
                  bringToFront = FALSE),
                label = labels,
                labelOptions = labelOptions(
                style = list("font-weight" = "normal", padding = "3px 8px"),
                textsize = "15px",
                direction = "auto")) |>
    addCircleMarkers(lat = data$latitudeDecimal,
                     lng = data$longitudeDecimal,
                     stroke = FALSE, fillOpacity = 0.9,
                     radius = 8,
                     clusterOptions = markerClusterOptions())

}

