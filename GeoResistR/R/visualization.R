# visualization.R

#' Plot time trend for a specific resistance gene
#'
#' @param data_time A data frame with temporal trend data
#' @param gene_id The gene identifier to visualize
#' @return A ggplot object showing the time trend of the gene's abundance
#' @export
plot_time_trend <- function(data_time, gene_id) {
  gene_data <- data_time %>% dplyr::filter(gene_id == gene_id)

  ggplot2::ggplot(gene_data, ggplot2::aes(x = date, y = mean_abundance)) +
    ggplot2::geom_line() +
    ggplot2::labs(title = paste("Time Trend for", gene_id),
                  x = "Date",
                  y = "Mean Abundance") +
    ggplot2::theme_minimal()
}
