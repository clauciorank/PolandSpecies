source("R/makeLeaflet.r")
source("R/makeTimeline.r")

library(shiny)
library(leaflet)
library(sf)
library(dplyr)

data <- data.table::fread("data/polandProvinces.csv")
choices_name <- c("All Species", sort(unique(data$scientificVernacular)))
map <- geojsonsf::geojson_sf("data/poland.geojson")


ui <- fluidPage(includeCSS("www/styles.css"),


    fluidRow(
        column(width = 8,
          h1("POLAND SPECIES OBSERVATIONS")
        ),
        column(width = 4,
          ui_inputs("id1"),
        )
    ),

     splitLayout(
       cellWidths = c("60%", "40%"),
       wellPanel(
         plot_map("id1")
        ),
       wellPanel(
         plot_timeline("id1")
       )
     )

)


server <- function(input, output, session) {

  species_name <- callModule(ui_server, "id1",
                              choices = choices_name)

  callModule(render_server, "id1",
              name_input = species_name,
              data = data,
              map = map)

}

# Run the application
shinyApp(ui = ui, server = server)
