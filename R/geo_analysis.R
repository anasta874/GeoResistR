plot_geo_distribution <- function(data, gene_id) {
  # Проверяем наличие нужных колонок
  if (!all(c("longitude", "latitude", "abundance", "organism", "gene_id") %in% colnames(data))) {
    stop("The dataset must contain 'longitude', 'latitude', 'abundance', 'organism', and 'gene_id' columns.")
  }

  # Фильтруем данные для конкретного гена
  gene_data <- dplyr::filter(data, gene_id == !!gene_id)

  # Диагностика: проверим, есть ли данные после фильтрации
  if (nrow(gene_data) == 0) {
    stop(paste("No data available for gene:", gene_id))
  }

  # Преобразуем данные в формат sf (пространственные данные)
  gene_sf <- sf::st_as_sf(gene_data, coords = c("longitude", "latitude"), crs = 4326)

  # Устанавливаем границы карты с небольшим отступом
  buffer <- 2  # Отступ в градусах
  xlim <- range(gene_data$longitude, na.rm = TRUE) + c(-buffer, buffer)
  ylim <- range(gene_data$latitude, na.rm = TRUE) + c(-buffer, buffer)

  # Загружаем карту мира
  world <- rnaturalearth::ne_countries(scale = "medium", returnclass = "sf")

  # Создаем график
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
    ggplot2::theme(
      plot.title = ggplot2::element_text(face = "bold", size = 14, hjust = 0.5),
      axis.title = ggplot2::element_text(size = 12),
      axis.text = ggplot2::element_text(size = 10)
    ) +
    ggplot2::scale_color_brewer(palette = "Set2")

  return(p)
}

