# Load the data
data <- load_resistome_data("../test_data/expanded_synthetic_resistome_data.csv")

# Perform time trend analysis
data_time <- analyze_time_trend(data)

# Plot the time trend for a specific gene
plot_time_trend(data_time, "blaCTX-M-15")

# Plot the geographical distribution for the same gene
plot_geo_distribution(data, "blaCTX-M-15")

# Forecast the future abundance of the gene over time
forecast_result <- forecast_abundance(data_time, "blaCTX-M-15", h = 10)
plot(forecast_result)





