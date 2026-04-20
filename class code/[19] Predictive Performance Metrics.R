## PREDICTIVE MODELING 
#### The goal is to get accurate predictions as opposed to interpretations

#### predictions are based on the models
#### yhat 
#### e.g., yhat = predict(finalreg, data = newdataset)

#### PREDICTIVE METRICS
#### Helpful on determining model performance on unseen data

## true values
y = c(23.5, 45.1, 34.7, 29.8)

## predicted values
yhat = c(25.7, 43, 35.5, 30.1)

#### 1) MEAN SQUARED ERROR (MSE)
###### this is not the MSE that we get in the regression anova

mse_pred = sum((y - yhat)^2) / 4  ## manual calc of MSE

install.packages('Metrics')
library(Metrics)


#### 2) ROOT MEAN SQUARED ERROR (RMSE)
rmse_pred = sqrt(mean((y - yhat)^2))

###### using the Metrics package
mse(y, yhat)
rmse(y, yhat)


#### 3) MEAN ABSOLUTE ERROR (MAE)
mae_pred = mean(abs(y - yhat))

mae(y, yhat)


#### 4) R2 (PREDICTIVE)
#### R2 = 1 - (SSE / SST)

#### SST = sum((y - ybar)^2)
SST = sum((y - mean(y))^2)

#### SSE = sum((y - yhat)^2)
SSE = sum((y - yhat)^2)

#### R2
R2 = 1 - (SSE / SST)


