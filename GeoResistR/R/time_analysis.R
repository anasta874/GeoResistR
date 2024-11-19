# time_analysis.R

#' Analyze temporal trends in resistance genes
#'
#' @param data A data frame with resistome data
#' @return A data frame with average abundance of each gene over time
#' @export
analyze_time_trend <- function(data) {
  data_time <- data %>%
    dplyr::group_by(gene_id, date) %>%
    dplyr::summarize(mean_abundance = mean(abundance, na.rm = TRUE))

  return(data_time)
}

