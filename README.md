# Revenue-Forecasting
Revenue Forecasting for an arbitrary sales data in the year 2020. Models created using R and results visualized with Tableau

I coded a few forecasting models and have attached the code for it (along with its results - final_output.csv) in this mail. The average mean absolute percentage error (MAPE) was ~9% with the Auto-Regressive Integrated Moving Average (ARIMA) model proving to be relatively more accurate among the other methods mentioned below.
Naive forecasting model
Exponential smoothing
Holt's trend method
TBATS
I analyzed the data and have developed a dashboard in Tableau highlighting the trends across segments (geography, medium, and type of form filled) and as a whole. I've also included two tabs with the forecasted values based on ARIMA and Exponential Smoothing with the option to filter per the three segments part of the data. I've enclosed the Tableau dashboard (but included the Tableau file with this mail) as images as Tableau Public doesn't support analytics extensions.

One noticeable insight is how there is a significant (by z-test) difference between the proportion of leads of the total generated organically in the APAC region vs. the EU and North American regions YTD (54% in APAC vs 26% in EU and 25% in NAMER).

A benchmark for comparison can be obtained with a measure of deviation (positive or negative) from the forecasted values, or to establish a measure of central tendency based on the prior values - for instance, 80th percentile and above could serve as the threshold for comparison. Performing t-test (to see statistical differences between aggregates) is not possible as the data series is homogeneous and there isn't a control group (A/B) to compare this against. Hope I understood the data right - please correct me if otherwise.

NOTE: Tableau would ask for a Tableau-R integration when opening the Tableau workbook. Please install the following libraries for establishing a connection (Rserve and forecast) and run the Rserve() function which would create a socket in Tableau for internal calculations. I've made some aggregate level changes to the data in timeseries.csv (data partitioning segmented by training and testing metrics) for the R scripts which would be presented as input to the function in R.
