packages <- c('shiny', 'leaflet', 'sf', 'dplyr', 'shinytest2',
                'data.table', 'stringr', 'htmltools', 'plotly',
                'ggplot2', 'geojsonsf', 'lubridate')


for (i in packages){
    if(! i %in% installed.packages()){
        install.packages(i)
    }else{
        NULL
    }
}