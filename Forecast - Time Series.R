# Importing necessary packages

library(readr)
library(forecast)
library(fpp2)
library(TTR)
library(dplyr)
library(lubridate)
# library(progress)

# Fetch data

dat <- read_csv("timeseries.csv")
glimpse(dat)
my_metrics <- dat$metric %>% unique

models <- function(metric_input) {
    # Data partitioning
    dat_train = filter(dat, class == 'train', metric == metric_input)
    dat_test = filter(dat, class == 'test', metric == metric_input)
    h <- nrow(dat_test)
    # Time-series object

    dat_ts <- ts(dat_train[, 4], start = c(1, 1))

    # MAPE: Mean Absolute Percentage Error
    mape <- function(actual,pred){
      mape <- mean(abs((actual - pred)/actual))*100
      return (mape)
    }

    # Naive forecasting methods
    naive_mod <- naive(dat_ts, h = 11) # Change h parameter for the # of forecasts reqd.
    # summary(naive_mod) #9.338352%
    df_naive = as_tibble(naive_mod)
    dat_test$naive = df_naive$'Point Forecast'

    dat_test$naive = naive_mod$'Point Forecast'
    # Exponential smoothing
    se_model <- ses(dat_ts, h = 11)
    # summary(se_model) #9.338352%
    df_se = as_tibble(se_model)
    dat_test$se = df_se$'Point Forecast'

    # Holt's trend method
    holt_model <- holt(dat_ts, h = 11)
    # summary(holt_model) #9.708708%

    df_holt = as_tibble(holt_model)
    dat_test$holt = df_holt$`Point Forecast`
    # mape(dat_test$count, dat_test$holt) #7.137216%

    # ARIMA
    arima_model <- auto.arima(dat_ts)
    # summary(arima_model)

    fore_arima = forecast::forecast(arima_model, h = 11)
    df_arima = as_tibble(fore_arima)
    dat_test$arima = df_arima$`Point Forecast`
    # mape(dat_test$count, dat_test$arima)  ## 9.706661%

    # TBATS
    model_tbats <- tbats(dat_ts)
    # summary(model_tbats)

    for_tbats <- forecast::forecast(model_tbats, h = 11)
    df_tbats = as_tibble(for_tbats)
    dat_test$tbats = df_tbats$`Point Forecast`
    # mape(dat_test$count, dat_test$tbats) #10.73375%
    return(dat_test)
}

final_output <- tibble()
# pb <- progress_bar$new(total = length(my_metrics))
for (metric in my_metrics) {
    # pb$tick()
    print(metric)
    final_output <- rbind(final_output, models(metric))
}

write_csv(final_output, "final_output.csv")
