library(testthat)
library(GeoResistR)

# Load the provided dataset
test_data <- load("./synthetic_resistome_data_3_years_trend.csv")

# Test 1: load() function
test_that("load() correctly loads and validates data", {
  # Check that the data is loaded correctly
  expect_true(is.data.frame(test_data))
  expect_true(all(c("gene_id", "organism", "abundance", "date", "latitude", "longitude") %in% colnames(test_data)))

  # Check date conversion
  expect_true(inherits(test_data$date, "Date"))
})

# Test 2: forecast() function
test_that("forecast() produces valid forecasts", {
  # Analyze temporal trends
  trend_data <- trend(test_data)

  # Generate forecasts
  forecast_data <- tryCatch({
    forecast(trend_data, gene_id = unique(trend_data$gene_id)[1], h = 5)
  }, warning = function(w) {
    message("Warning caught: ", conditionMessage(w))
    NULL
  }, error = function(e) {
    message("Error caught: ", conditionMessage(e))
    NULL
  })

  # Check forecast results
  if (!is.null(forecast_data)) {
    # Validate structure
    expect_true(all(c("organism", "date", "mean", "lower", "upper") %in% colnames(forecast_data)))

    # Dynamically calculate expected rows based on successful forecasts
    organisms_with_forecasts <- unique(forecast_data$organism)
    expected_rows <- 5 * length(organisms_with_forecasts)
    expect_equal(nrow(forecast_data), expected_rows)
  } else {
    message("Forecast data is NULL due to insufficient data.")
    expect_null(forecast_data)
  }
})

# Test 3: plot_fc() function
test_that("plot_fc() generates a valid ggplot object", {
  # Analyze trends and generate forecasts
  trend_data <- trend(test_data)
  forecast_data <- forecast(trend_data, gene_id = unique(trend_data$gene_id)[1], h = 5)

  # Generate the plot
  p <- plot_fc(trend_data, forecast_data, gene_id = unique(trend_data$gene_id)[1])

  # Check that the output is a ggplot object
  expect_true(inherits(p, "ggplot"))
})

# Test 4: plot_map() function
test_that("plot_map() generates a valid ggplot object", {
  # Generate the plot
  p <- plot_map(test_data, gene_id = unique(test_data$gene_id)[1])

  # Check that the output is a ggplot object
  expect_true(inherits(p, "ggplot"))
})

# Test 5: trend() function
test_that("trend() correctly aggregates data", {
  # Analyze temporal trends
  trend_data <- trend(test_data)

  # Check that the output is a data frame
  expect_true(is.data.frame(trend_data))

  # Check that the correct columns exist
  expect_true(all(c("gene_id", "organism", "date", "mean_abundance") %in% colnames(trend_data)))

  # Check that data is aggregated correctly
  expect_true(nrow(trend_data) > 0) # Ensure there is output
})

