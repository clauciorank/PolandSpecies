ui_inputs <- function(id){
  ns <- shiny::NS(id)

  shiny::selectizeInput(ns("name"), "Search species:", choices = NULL, selected = "All Species", width = "100%")
}


plot_map <- function(id){
  ns <- shiny::NS(id)

  leaflet::leafletOutput(ns("plotMap"), height = 800)
}


plot_timeline <- function(id){
  ns <- shiny::NS(id)

  plotly::plotlyOutput(ns("timeline"), height = 800)
}


ui_server <- function(input, output, session, choices){
  shiny::updateSelectizeInput(session, "name",choices = choices, server = TRUE)
  return(shiny::reactive({input$name}))
}


render_server <- function(input, output, session, name_input, data, map){

  data_reactive <- reactive({
    req(name_input())
    if(name_input() == "All Species"){
      data
    }else{
      data |>
        dplyr::filter(scientificVernacular == name_input())
    }
  })

  map_reactive <- reactive({
      summary <- data_reactive() |>
        dplyr::group_by(stateProvince) |>
        summarise(n = n())
      map <- map |>
        left_join(summary, by = c("nazwa" = "stateProvince"))
    })


  output$plotMap <- renderLeaflet({
      make_leaflet(map_reactive(), data_reactive())
    })


  output$timeline <- plotly::renderPlotly({
      make_timeline(data_reactive())
    })
}