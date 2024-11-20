*This project is currently under development and is not ready for production use.

# GeoResistR

**GeoResistR** is a lightweight R package designed to analyze antibiotic resistance gene dynamics over time and across geographic locations. It provides essential tools for loading and processing resistome data, conducting temporal and spatial analyses, and generating visualizations to help researchers understand trends and patterns in antibiotic resistance.

## Input Data Format

The **GeoResistR** package requires input data in the form of a CSV file with a specific structure. The table should include the following columns:

- **gene_id**: (Character) The identifier of the antibiotic resistance gene, e.g., "blaCTX-M-15".
- **sample_id**: (Character) A unique identifier for each sample, e.g., "S001".
- **abundance**: (Numeric) The measured abundance level of the gene in the sample, represented as a numeric value.
- **date**: (Date) The date the sample was collected, in the format `YYYY-MM-DD`, e.g., "2023-07-10".
- **latitude**: (Numeric) The latitude of the sampling location, e.g., `41.29554`.
- **longitude**: (Numeric) The longitude of the sampling location, e.g., `-121.91890`.

### Example Table

| gene_id    | sample_id | abundance | date       | latitude | longitude |
|------------|-----------|-----------|------------|----------|-----------|
| blaCTX-M-15 | S001      | 14.0      | 2023-07-10 | 41.29554 | -121.91890 |
| ermC       | S002      | 12.5      | 2023-12-09 | 53.62438 | -81.10948  |
| blaNDM     | S003      | 8.1       | 2023-03-17 | 47.56747 | -88.55673  |
| poxtA      | S004      | 27.9      | 2023-10-18 | 34.45181 | -116.17952 |
| cfr        | S005      | 24.5      | 2023-06-06 | 51.37709 | -121.81001 |

### Important Notes

- Ensure that the **date** column is in the correct date format (`YYYY-MM-DD`).
- **gene_id** and **sample_id** should be unique identifiers and are required for proper data analysis.
- Missing or misformatted data in any of these columns may cause errors or unexpected behavior in the analysis functions.

Make sure to format your data according to this structure to ensure compatibility with the **GeoResistR** functions.

## Features

- **Data Import**: Load and preprocess resistome data from CSV files.
- **Temporal Analysis**: Analyze temporal trends in the abundance of resistance genes.
- **Forecasting**: Use time series analysis to predict future trends in resistance gene abundance.
- **Geospatial Analysis**: Map the distribution of antibiotic resistance genes across geographic locations.
- **Visualization**: Create time trend and geographic distribution visualizations for exploratory analysis.

## Installation

To install **GeoResistR**, clone this repository and use `devtools` to install locally:

```r
# Install devtools if not already installed
install.packages("devtools")

# Install GeoResistR from local directory
devtools::install("path/to/GeoResistR")
```

## Usage

Here’s a quick example of how to use **GeoResistR** to load data, analyze temporal trends, and create visualizations.

### 1. Load Resistome Data

Load the resistome data from a CSV file:

```r
library(GeoResistR)

# Load data
data <- load_resistome_data("path/to/your_data.csv")
head(data)
```
### 2. Temporal Analysis

Analyze temporal trends in the abundance of a specific resistance gene:

```r
# Analyze temporal trends
data_time <- analyze_time_trend(data)

# Plot time trend for a specific gene
plot_time_trend(data_time, "blaCTX-M-15")
```

### 3. Geospatial Analysis

Visualize the geographic distribution of a resistance gene:

```r
# Plot geographic distribution
plot_geo_distribution(data, "blaCTX-M-15")
```

### 4. Forecasting Abundance

Forecast the future abundance of a gene over time:

```r
# Forecast future abundance
forecast_result <- forecast_abundance(data_time, "blaCTX-M-15", h = 30)
plot(forecast_result)
```

## Project Structure

The main components of the package are organized as follows:

- **R/**: Contains the core functions for data import, analysis, and visualization:
  - `data_import.R`: Functions for loading resistome data.
  - `forecast_analysis.R`: Functions for time series forecasting.
  - `geo_analysis.R`: Functions for geospatial analysis.
  - `time_analysis.R`: Functions for temporal trend analysis.
  - `visualization.R`: Functions for generating plots.

- **man/**: Contains the documentation files (`.Rd`) for each function.

- **test_data/**: Contains example datasets for testing and demonstration purposes:
  - `example_GeoResistR.R`: Sample script demonstrating package functionality.
  - `expanded_synthetic_resistome_data.csv`: Synthetic data with multiple genes.
  - `synthetic_resistome_data_with_trend.csv`: Synthetic data with added trend and seasonality.

