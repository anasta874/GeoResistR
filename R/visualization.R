# visualization.R
# Functions for geographical and combined temporal visualizations

#' Plot geographical distribution for a specific gene
#'
#' @param data A data frame with resistome data
#' @param gene_id The gene ID to plot
#' @return A ggplot object with the geographical distribution
#' @export
plot_map <- function(data, gene_id) {
  if (!all(c("longitude", "latitude", "abundance", "organism", "gene_id") %in% colnames(data))) {
    stop("The dataset must contain 'longitude', 'latitude', 'abundance', 'organism', and 'gene_id' columns.")
  }

  # Filter data for the given gene
  gene_data <- dplyr::filter(data, gene_id == !!gene_id)

  if (nrow(gene_data) == 0) {
    stop(paste("No data available for gene:", gene_id))
  }

  # Convert data to spatial format
  gene_sf <- sf::st_as_sf(gene_data, coords = c("longitude", "latitude"), crs = 4326)

  # Add a buffer to map boundaries
  buffer <- 2
  xlim <- range(gene_data$longitude, na.rm = TRUE) + c(-buffer, buffer)
  ylim <- range(gene_data$latitude, na.rm = TRUE) + c(-buffer, buffer)

  # Load world map
  world <- rnaturalearth::ne_countries(scale = "medium", returnclass = "sf")

  # Generate the plot
  p <- ggplot2::ggplot(data = world) +
    ggplot2::geom_sf(fill = "gray90", color = "gray50") +
    ggplot2::geom_sf(data = gene_sf,
                     ggplot2::aes(size = abundance, color = organism),
                     alpha = 0.7) +
    ggplot2::coord_sf(xlim = xlim, ylim = ylim, expand = FALSE) +
    ggplot2::labs(
      title = paste("Geographical Distribution for", gene_id),
      x = "Longitude",
      y = "Latitude",
      size = "Abundance",
      color = "Organism"
    ) +
    ggplot2::theme_minimal() +
    ggplot2::scale_color_brewer(palette = "Set2")

  return(p)
}

#' Plot temporal trends and forecast by organism
#'
#' @param data_time A data frame with time trend data
#' @param forecast_df The forecast data frame created by `forecast`
#' @param gene_id The gene ID to plot
#' @return A ggplot object showing the temporal trend and forecast by organism
#' @export
plot_fc <- function(data_time, forecast_df, gene_id) {
  Sys.setlocale("LC_TIME", "C") # Ensure English locale for dates
  original_data <- dplyr::filter(data_time, gene_id == !!gene_id)

  if (nrow(original_data) == 0) {
    stop(paste("No data found for gene:", gene_id))
  }

  original_data$date <- as.Date(original_data$date)

  # Generate the plot
  p <- ggplot2::ggplot() +
    # Original data (line and points)
    ggplot2::geom_line(
      data = original_data,
      ggplot2::aes(x = date, y = mean_abundance, color = organism),
      linewidth = 0.8 # Updated from size to linewidth
    ) +
    ggplot2::geom_point(
      data = original_data,
      ggplot2::aes(x = date, y = mean_abundance, color = organism),
      size = 1
    ) +
    # Forecasted data (line and ribbon)
    ggplot2::geom_line(
      data = forecast_df,
      ggplot2::aes(x = date, y = mean, color = organism),
      linetype = "dashed", linewidth = 0.8 # Updated from size to linewidth
    ) +
    ggplot2::geom_ribbon(
      data = forecast_df,
      ggplot2::aes(x = date, ymin = lower, ymax = upper, fill = organism),
      alpha = 0.2
    ) +
    ggplot2::labs(
      title = paste("Temporal Trend and Forecast for", gene_id, "by Organism"),
      x = "Date",
      y = "Mean Abundance",
      color = "Organism",
      fill = "Organism"
    ) +
    ggplot2::theme_minimal() +
    ggplot2::scale_color_brewer(palette = "Set2") +
    ggplot2::scale_fill_brewer(palette = "Set2")

  return(p)
}
