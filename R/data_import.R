# data_import.R

#' Load resistome data with time and location metadata
#'
#' @param file_path Path to the CSV file containing resistome data
#' @return A data frame with resistome data
#' @export
load_resistome_data <- function(file_path) {
  data <- read.csv(file_path)


  if (!all(c("gene_id", "sample_id", "abundance", "date", "latitude", "longitude") %in% colnames(data))) {
    stop("Data must include columns: 'gene_id', 'sample_id', 'abundance', 'date', 'latitude', 'longitude'")
  }


  data$date <- lubridate::ymd(data$date)
  data <- dplyr::mutate(data,
                        latitude = as.numeric(latitude),
                        longitude = as.numeric(longitude))

  return(data)
}
