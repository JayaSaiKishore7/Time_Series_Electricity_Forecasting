# Time Series Electricity Forecasting + WNN R Package

End-to-end time series forecasting project combining machine learning (Python) and a research-paper algorithm implemented as an R package.




# Project Summary

This project forecasts electricity consumption for a commercial building using data measured every 15 minutes.

Forecast horizon: 24 hours (96 time steps)

The project is divided into two major parts:

- Part 1: Benchmark and compare forecasting models in Python

- Part 2: Implement the Weighted Nearest Neighbours (WNN) algorithm as a reusable R package and compare it with the best model



# Dataset

The dataset contains:

- Electricity consumption (kW)

- Outdoor temperature

- Time range: Jan 2010 → Feb 2010

- Sampling frequency: 15-minute intervals

Goal: predict consumption for the next day (96 future observations).


## Part 1 — Forecasting Pipeline (Python)

A complete forecasting pipeline was developed and evaluated using time-series cross-validation.

Models Implemented
Baselines

- Naive

- Seasonal Naive

Statistical Models

- Exponential Smoothing (ETS)

- SARIMA

Machine Learning Models

- Random Forest

- Support Vector Regression (SVR)

- XGBoost

- Multi-Layer Perceptron (MLP)

- LSTM Neural Network

# Feature Engineering

The machine learning models used supervised learning on lagged features.

Features created:

- 96 lag features (previous 24 hours)

- Rolling statistics

- Time-based features (hour, day)

- Recursive multi-step forecasting

# Model Selection

All models were tuned and evaluated using TimeSeriesSplit cross-validation.

Best model: Random Forest
Chosen for stability and lowest validation error.

Final forecast saved as:
 ```
JayaSaiKishore.xlsx

 ```


# Part 2 — Weighted Nearest Neighbours (WNN)

This part implements the research papers:

Talavera-Llames et al., 2016 — A Nearest Neighbours-Based Algorithm for Big Time Series Forecasting

Key Idea

Instead of training a model, WNN finds historical patterns similar to the latest observations and uses them to predict the future.


WNN Algorithm Steps

- Convert the time series into sliding windows (embedding)

- Compute Euclidean distance between the latest window and past windows

- Select the k nearest neighbours

- Assign weights inversely proportional to distance

- Forecast using weighted average

- Repeat recursively for multi-step forecasting

Parameters Used

- Window size: 96

- Forecast horizon: 96

- Number of neighbours: k = 10

# R Package — WNNForecast

The WNN algorithm was implemented as a fully installable R package.

Package Features

- wnn_fit() → builds the WNN model

- wnn_forecast() → generates forecasts

- Documentation generated with roxygen2

- Vignette demonstrating usage

- Installable on any machine (Mac/Linux/Windows)
 ```

install.packages("JayaSaiKishore.tar.gz", repos = NULL, type = "source")
library(WNNForecast)

 ```

 ```
model <- wnn_fit(series, lag_window = 96, k = 10)
forecast <- wnn_forecast(model, h = 96)

 ```

# Results

Comparison between Random Forest and WNN:

Metric	Value
MAE	5.32
RMSE	13.14

WNN produced forecasts very close to the machine learning model while remaining simple and interpretable.


# Project Deliverables

- JayaSaiKishore.xlsx → Final 96-step forecast

- JayaSaiKishore.tar.gz → R package (WNNForecast)

- JayaSaiKishore.pdf → Project report

# Skills Demonstrated

- Time series forecasting

- Feature engineering for ML

- Recursive multi-step forecasting

- Model benchmarking and hyperparameter tuning

- R package development

- Reproducible research workflow

