# trend_analysis.R
# Functions for analyzing and visualizing temporal trends

#' Analyze temporal trends in resistance genes by organism
#'
#' @param data A data frame with resistome data
#' @return A data frame with average abundance of each gene and organism over time
#' @export
trend <- function(data) {
  data$date <- as.Date(data$date, format = "%Y-%m-%d")

  data_time <- dplyr::summarize(
    dplyr::group_by(data, gene_id, organism, date),
    mean_abundance = mean(abundance, na.rm = TRUE),
    .groups = "drop"
  )

  return(data_time)
}

#' Plot temporal trends for a specific resistance gene and organism
#'
#' @param data_time A data frame with time trend data (output of trend)
#' @param gene_id The gene ID to plot
#' @param organism (Optional) The organism to filter
#' @return A ggplot object with the time trend
#' @export
plot_tr <- function(data_time, gene_id, organism = NULL) {
  filtered_data <- dplyr::filter(data_time, gene_id == !!gene_id)

  if (!is.null(organism)) {
    filtered_data <- dplyr::filter(filtered_data, organism == !!organism)
  }

  p <- ggplot2::ggplot(filtered_data, ggplot2::aes(x = date, y = mean_abundance, color = organism)) +
    ggplot2::geom_line(size = 0.5) +
    ggplot2::geom_point(size = 0.8) +
    ggplot2::geom_smooth(method = "loess", se = FALSE, size = 1) +
    ggplot2::labs(
      title = if (!is.null(organism)) {
        paste("Time Trend for", gene_id, "in", organism)
      } else {
        paste("Time Trend for", gene_id)
      },
      x = "Date",
      y = "Mean Abundance",
      color = "Organism"
    ) +
    ggplot2::theme_minimal() +
    ggplot2::scale_color_brewer(palette = "Set2")

  return(p)
}

