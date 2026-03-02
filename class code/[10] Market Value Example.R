## House Market Price Example
#### MLR, F-statistic, adj-R2

## Read the data
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA391/refs/heads/main/data/MarketValueData.csv',
              stringsAsFactors = T)

head(df)

## select x1 = House_Age, x2 = Sqr_Ft, y = Mkt_Value_1000s
df = df[, c("House_Age", "Sqr_Ft", "Mkt_Value_1000s")]

## scatter plot of x1 vs y
plot(df$House_Age, df$Mkt_Value_1000s)
abline(lm(Mkt_Value_1000s ~ House_Age, data = df), col = "red")

## scatter plot of x2 vs y
plot(df$Sqr_Ft, df$Mkt_Value_1000s)
abline(lm(Mkt_Value_1000s ~ Sqr_Ft, data = df), col = "red")

## scatter plot matrix
plot(df) 


## Fit a first-order model 
reg1 = lm(Mkt_Value_1000s ~ House_Age + Sqr_Ft, data = df)
summary(reg1)
anova(reg1)

## Interpret the estimate of the y-intercept in the language of the problem
#### T or (F) - all variables have to be zero 
#### The estimated price of the homes, if house age is zero (brand new price), (with zero sq ft)

## Interpret the slope for house age (language of the problem)
#### As house age increases by 1 year, the estimated price would decrease by $825 (keep sq ft constant)
#### comparing similar houses (in terms of size), not changing the size of the home


## R2 (Explained / Total Variation)
anova(reg1)


### SSE (Sum of squared errors) - Total Unexplained 
SSE = 2028.42  ## minimize

### SSR (House Age) - Explained variation by House Age
SSR_House_Age = 596.42


### SSR (Sq Ft) - EXTRA Explained variation by Sq Ft
SSR_Sq_Ft = 1941.23

### SSR (Total Explained Variation)
SSR = SSR_House_Age + SSR_Sq_Ft
SSR

### SST (Total Variation of Market_Value)
SST = SSR + SSE
SST

### R2 = SSR / SST
R2 = SSR / SST
R2


### We have to adjust R2 depending on the number of predictors


## What is the estimated error?
#### Residual std error
#### RMSE
#### Residual standard error: 7.212
#### or sqrt of MSE
sqrt(52.01)

#### % of the variation explained
#### adj.R2 = 53.3%



## 3D PLANE
library(car)
library(rgl)
scatter3d(Mkt_Value_1000s ~ House_Age + Sqr_Ft, data = df)


## F-TEST
#### tHE F-statistic is computed as F = (SSR / k) / (SSE / n - (k+1)) 
#### F = ratio of Explained variation to Unexplained variation
#### the larger F is, the better the model

#### H0: Beta_House_Age = Beta_Sq_Ft = 9
#### HA: At least one of them is NOT zero

#### F = 24.4 (F-distribution 2 and 39)
#### p-value: 1.344e-07
#### Probability that we get an F-statistic (24.4) as large or larger given H0 is true
#### Probability is basically
#### CONCLUSION: We reject H0 and conclude that at least one variable is important


