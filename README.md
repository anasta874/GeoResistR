
## ⚠️ Disclaimer:
This project is currently under development and is not ready for production use.

# GeoResistR

**GeoResistR** is an R package designed to analyze antibiotic resistance gene dynamics over time and across geographic locations. The package provides tools for loading data, temporal analysis, ARIMA-based forecasting, and geospatial visualization.

## When to Use GeoResistR

**GeoResistR** can be used in the following scenarios:

1. **Long-term Data Monitoring**:
   - Analyze antibiotic resistance trends over months or years.
   - Example: Monitoring resistance levels in hospital or environmental systems.

2. **Geospatial Analysis**:
   - Visualize geographic distributions of resistance genes to identify hotspots.
   - Example: Mapping `blaCTX-M-15` across different regions.

3. **Short-term Forecasting**:
   - Predict future resistance levels using ARIMA-based forecasting.
   - Example: Forecast abundance of `ermC` for the next 12 months.

4. **Organism Comparisons**:
   - Compare resistance trends across different organisms.
   - Example: Observing trends in `E. coli` vs. `S. aureus`.

5. **Seasonal Trends**:
   - Detect and analyze seasonal patterns in resistance data.
   - Example: Observing summer peaks in resistance gene abundance.

6. **Regional or Global Studies**:
   - Suitable for monitoring resistance at regional or global scales.
   - Example: Tracking the spread of `blaNDM` worldwide.

**Requirements**:
- Input data must include `gene_id`, `organism`, `date`, `abundance`, `latitude`, and `longitude`.
- At least 5 time points are needed for ARIMA forecasts.
- Recommended for datasets spanning multiple months or years.**

---

## Input Data Format

The **GeoResistR** package requires input data in CSV format with the following structure:

| Column Name | Description                                                                 |
|-------------|-----------------------------------------------------------------------------|
| **gene_id** | (Character) Identifier of the resistance gene (e.g., "blaCTX-M-15").        |
| **organism**| (Character) Organism associated with the resistance gene (e.g., "E. coli").|
| **sample_id**| (Character) Unique identifier for each sample (e.g., "S001").             |
| **abundance**| (Numeric) Measured abundance of the gene in the sample.                   |
| **date**    | (Date) Collection date in `YYYY-MM-DD` format (e.g., "2023-07-10").        |
| **latitude**| (Numeric) Latitude of the sampling location (e.g., `41.29554`).            |
| **longitude**| (Numeric) Longitude of the sampling location (e.g., `-121.91890`).        |

### Example Table

| gene_id    | organism       | sample_id | abundance | date       | latitude  | longitude  |
|------------|----------------|-----------|-----------|------------|-----------|------------|
| blaCTX-M-15 | E. coli        | S001      | 14.0      | 2023-07-10 | 41.29554  | -121.91890 |
| ermC        | S. aureus      | S002      | 12.5      | 2023-12-09 | 53.62438  | -81.10948  |
| blaNDM      | K. pneumoniae  | S003      | 8.1       | 2023-03-17 | 47.56747  | -88.55673  |
| poxtA       | E. faecalis    | S004      | 27.9      | 2023-10-18 | 34.45181  | -116.17952 |
| cfr         | S. epidermidis | S005      | 24.5      | 2023-06-06 | 51.37709  | -121.81001 |

### Important Notes

- Ensure that the **date** column is in the correct `YYYY-MM-DD` format.
- The **organism** column should contain valid organism names for proper grouping and analysis.
- Missing or misformatted data in any column may cause errors or unexpected behavior.

---

## Features

1. **Data Import**: Easily load resistome data from CSV files.
2. **Temporal Analysis**: Analyze trends in resistance gene abundance over time.
3. **Forecasting**: Use ARIMA models to predict future abundance trends.
4. **Geospatial Analysis**: Map the geographic distribution of resistance genes.
5. **Visualization**: Create temporal and spatial visualizations for exploratory analysis.

---

## Installation

To install **GeoResistR**, clone this repository and use `devtools`:

```r
# Install devtools if not already installed
install.packages("devtools")

# Install GeoResistR from local directory
devtools::install("path/to/GeoResistR")
```

---

## Usage

### 1. Load Resistome Data

```r
library(GeoResistR)

# Load data
data <- load("path/to/your_data.csv")
head(data)
```

### 2. Temporal Analysis

Analyze trends in the abundance of specific resistance genes over time:

```r
# Analyze temporal trends
data_time <- trend(data)

# Plot time trends for a specific gene
plot_tr(data_time, "blaCTX-M-15")
```

### 3. Geospatial Analysis

Visualize the geographic distribution of a resistance gene:

```r
# Plot geographic distribution
plot_map(data, "blaCTX-M-15")
```

### 4. Forecasting Abundance

Use ARIMA to forecast the abundance of a gene:

```r
# Forecast abundance for a specific gene
forecast_result <- forecast(data_time, "blaCTX-M-15", h = 12)

# Visualize the forecast
plot_fc(data_time, forecast_result, "blaCTX-M-15")
```

---

## Project Structure

| Directory/File                  | Description                                                                 |
|---------------------------------|-----------------------------------------------------------------------------|
| **R/**                         | Core functions for data loading, analysis, and visualization.               |
| **tests/**                     | Unit tests for all major functions and example data for testing.            |
| **man/**                       | Documentation files for all exported functions (`.Rd`).                     |
| **DESCRIPTION**                | Metadata for the package (e.g., dependencies, version).                     |
| **NAMESPACE**                  | Exported functions and package imports.                                     |
| **README.md**                  | Main documentation file for the package.                                    |

---

### Core Functions

| Function      | Purpose                                                                 |
|---------------|-------------------------------------------------------------------------|
| `load`        | Load and preprocess resistome data from CSV.                           |
| `trend`       | Analyze temporal trends in resistance gene abundance.                  |
| `forecast`    | Forecast future trends using ARIMA.                                    |
| `plot_tr`     | Visualize temporal trends for resistance genes.                        |
| `plot_map`    | Visualize geographic distribution of resistance genes.                 |
| `plot_fc`     | Combine temporal trend visualization with forecasting results.         |

---

## Example Datasets

The `tests/testthat` directory contains synthetic datasets for testing and demonstration:
1. **`synthetic_resistome_data_3_years_trend.csv`**: Example dataset with trends and geospatial data.

---

## Notes for Development

- This package is currently under development and not yet production-ready.
- Contributions and feedback are welcome to improve functionality and expand features.

---

## When to Use GeoResistR

**GeoResistR** is ideal for the following scenarios:

1. **Long-term Data Monitoring**:
   - Analyze antibiotic resistance trends over months or years.
   - Example: Monitoring resistance levels in hospital or environmental systems.

2. **Geospatial Analysis**:
   - Visualize geographic distributions of resistance genes to identify hotspots.
   - Example: Mapping `blaCTX-M-15` across different regions.

3. **Short-term Forecasting**:
   - Predict future resistance levels using ARIMA-based forecasting.
   - Example: Forecast abundance of `ermC` for the next 12 months.

4. **Organism Comparisons**:
   - Compare resistance trends across different organisms.
   - Example: Observing trends in `E. coli` vs. `S. aureus`.

5. **Seasonal Trends**:
   - Detect and analyze seasonal patterns in resistance data.
   - Example: Observing summer peaks in resistance gene abundance.

6. **Regional or Global Studies**:
   - Suitable for monitoring resistance at regional or global scales.
   - Example: Tracking the spread of `blaNDM` worldwide.

**Requirements**:
- Input data must include `gene_id`, `organism`, `date`, `abundance`, `latitude`, and `longitude`.
- At least 5 time points are needed for ARIMA forecasts.
- Recommended for datasets spanning multiple months or years.
