# geo_analysis.R

#' Plot geographical distribution of a specific resistance gene
#'
#' @param data A data frame with resistome data
#' @param gene_id The gene identifier to visualize
#' @return A ggplot object showing the geographical distribution of the gene's abundance
#' @export
plot_geo_distribution <- function(data, gene_id) {
  gene_data <- data %>% dplyr::filter(gene_id == gene_id)

  ggplot2::ggplot(gene_data, ggplot2::aes(x = longitude, y = latitude)) +
    ggplot2::geom_point(ggplot2::aes(size = abundance), color = "blue", alpha = 0.6) +
    ggplot2::labs(title = paste("Geographical Distribution for", gene_id),
                  x = "Longitude",
                  y = "Latitude") +
    ggplot2::theme_minimal() +
    ggplot2::coord_fixed()
}
