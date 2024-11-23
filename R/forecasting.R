# forecasting.R
# Functions for abundance forecasting

#' Create a forecast for abundance data by organism using ARIMA
#'
#' @param data_time A filtered data frame with time trend data for one gene
#' @param gene_id The gene ID to forecast
#' @param h Number of future periods to forecast
#' @return A data frame with mean, lower, and upper predictions for each organism
#' @export
forecast <- function(data_time, gene_id, h = 10) {
  filtered_data <- dplyr::filter(data_time, gene_id == !!gene_id)

  if (nrow(filtered_data) == 0) {
    stop(paste("No data found for gene:", gene_id))
  }

  filtered_data$date <- as.Date(filtered_data$date)
  filtered_data <- dplyr::arrange(filtered_data, organism, date)

  forecast_results <- list()
  organisms <- unique(filtered_data$organism)
  for (org in organisms) {
    org_data <- dplyr::filter(filtered_data, organism == org)

    if (nrow(org_data) < 5) {
      warning(paste("Not enough data points for ARIMA for organism:", org))
      next
    }

    ts_data <- ts(org_data$mean_abundance, frequency = 12)

    arima_model <- forecast::auto.arima(ts_data)

    future_dates <- seq(
      from = max(org_data$date) + 1,
      by = "month",
      length.out = h
    )

    forecast_result <- forecast::forecast(arima_model, h = h)

    forecast_results[[org]] <- data.frame(
      organism = org,
      date = future_dates,
      mean = as.numeric(forecast_result$mean),
      lower = as.numeric(forecast_result$lower[, 2]),
      upper = as.numeric(forecast_result$upper[, 2])
    )
  }

  forecast_df <- dplyr::bind_rows(forecast_results)
  return(forecast_df)
}
