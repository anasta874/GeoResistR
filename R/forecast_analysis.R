# forecast_analysis.R

#' Forecast abundance of a specific resistance gene over time
#'
#' @param data_time A data frame with temporal trend data
#' @param gene_id The gene identifier to forecast
#' @param h The number of periods to forecast
#' @return A forecast object showing the predicted abundance
#' @export
forecast_abundance <- function(data_time, gene_id, h = 10) {
  gene_data <- data_time %>% dplyr::filter(gene_id == gene_id)
  ts_data <- ts(gene_data$mean_abundance, start = c(lubridate::year(min(gene_data$date)), lubridate::month(min(gene_data$date))), frequency = 12)

  model <- forecast::auto.arima(ts_data)
  forecast_result <- forecast::forecast(model, h = h)

  return(forecast_result)
}
