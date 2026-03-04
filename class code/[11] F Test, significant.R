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



## PARTIAL SIGNIFICANCE
#### in MLR, when a variable is insignificant, we  can say:
#### given the other variables in the model, house age (example)
#### is NOT statistically significant. It does not too much.
summary(reg1)

## MSE (MEAN SQUARED ERROR)
anova(reg1)

## AVERAGE UNEXPLAINED VARIATION BY OBS
## MSE = SSE / Df (Error Df - t statistic)  (n - (k+1))
## Error df (we want that value to be high)
MSE = 2028.42 / 39


## AVERAGE EXPLAINED VARIATION BY VARIABLE
## MSR = SSR / Df (Model Df - k or number of predictors)
MSR = (596.42 + 1941.23) / 2


## RATIO
#### this is ratio of explained to unexplained variation
Fstat = MSR / MSE
Fstat

## Fstat has a distribution
#### F distribution (with model df in the num, error df in denominator)
#### Fstat ~ F(2, 39)


## H0: all true slopes are zero. No variable is important 
## H0: Beta_1 = Beta_2 = 0

## HA: At least one variable is one.

## Overall, the model explains well


## confidence intervals on the ESTIMATES (slopes, y-intercep)
confint(reg1, level = 0.99)


## Assumptions 
#### 1) mean(E) = 0
#### 2) var(E) = sigma^2
#### 3) E ~ N(0, sigma^2)
#### 4) E independent 

plot(reg1)

### easier plot
par(mfrow = c(2,2))
plot(reg1)
par(mfrow = c(1,1))

#### 1) mean error term
##### The errors are centered around zero 
mean(reg1$residuals)

#### 2) var(E)
##### The residuals vs fitted plot
##### shows the errors are fairly constant

#### 3) E ~ N
#### The Q-Q Residuals plots shows residuals are fairly normal

#### 4) There is no time (order) variable


## POINT ESTIMATES
new_house = data.frame(House_Age = 34, Sqr_Ft = 2064)
predict(reg1, new_house)

## C.I. ON THE AVERAGE PRICE (95%)
predict(reg1, new_house, interval = "confidence")


## P.I ON A SPECIFIC HOUSE (95%)
predict(reg1, new_house, interval = "prediction")






