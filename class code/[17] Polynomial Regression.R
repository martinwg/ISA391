## POLYNOMIAL REGRESSION


#### READ DATA
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA391/refs/heads/main/data/store_sales.csv',
              stringsAsFactors = T)

head(df)

#### PLOT DATA
plot(df)

#### Advertising Expenditures seems non-linear
#### As adv exp increases sales generally increase
#### but up to a point

## first-order regression
reg1 = lm(Sales ~ ., data = df)
summary(reg1)

## what is the ref for Region?
## East (ref)

## which region has the most sales?
## west

## should I drop RegionNorth from the model?
#### rationale: it is NOT statistically significant
#### Region is ONE variable

#### Estimate of RegionNorth is 2.38947

## Estimate for AdvertisingSpend
#### As AdvertisingSpend increase by $1 hundred 000 then we estimate
#### the sales to increase $18MM holding every thing else constant


## first-order models assume the relationship continues to linear

plot(df$AdvertisingSpend, df$Sales)
abline(lm(Sales ~ AdvertisingSpend, data = df), col = "red", lwd = 3)

## We want to add a quadratic term on the AdvertisingSpend
## and test for significance
## in R quadratic terms 
## I(AdvertisingSpend^2)

reg1 = lm(Sales ~ . + I(AdvertisingSpend^2), data = df)
summary(reg1)

## B1 (AdvertisingSpend) =    + (increasing)
## B6 (AdvertisingSpend^2) =  - (at a decreasing rate)

## Interpret the effect of AdvertisingSpend on Sales (-3*x^2  ---  -2(3)x )
#### Effect: 25.47060 + 2*-0.30069*AdvertisingSpend
##### if AdvertisingSpend = 1
##### and it increases by 1 (increase to 2), then sales are estimated to increase by
##### 24.86922 


## plot the 3D curve
library(rgl)
library(car)
scatter3d(Sales ~ AdvertisingSpend + StoreSize | Region, data = df, fit = "quadratic")















