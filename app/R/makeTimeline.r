make_timeline <- function(data){
    plotly::ggplotly(
    data |>
        dplyr::mutate(Year = lubridate::year(eventDate)) |>
        dplyr::group_by(Year) |>
        dplyr::summarise(Observations = dplyr::n()) |>
        ggplot2::ggplot(ggplot2::aes(Year, Observations)) +
        ggplot2::geom_bar(stat = "identity", fill = "#517cb4")+
        ggplot2::xlim(1984, 2021)+
        ggplot2::labs(y = "Number of Observations")+
        ggplot2::theme(text = ggplot2::element_text(size = 24))+
        ggplot2::theme_minimal()
    ) |>
    plotly::config(displayModeBar = F) |>
    plotly::layout(xaxis=list(fixedrange=TRUE)) |>
    plotly::layout(yaxis=list(fixedrange=TRUE))
}





