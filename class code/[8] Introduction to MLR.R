## Introduction to Multiple Linear Regression
#### we have x1, x2, ..., xk

## Bike Crossings in NYC
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA391/refs/heads/main/data/nyc-east-river-bicycle-counts.csv',
              stringsAsFactors = T)


## print some obs
head(df)

## Select high and low temps (related)
df = df[, c('High.Temp.F', 'Low_Temp_F', 'Total')]


## scatter plot (high temp and Total)
plot(df$High.Temp.F, df$Total)

## scatter plot (low temp and Total)
plot(df$Low_Temp_F, df$Total)

#### which variable is more predictive of the total crossings?
## High Temp is a better predictor (visually)

#### what type of LINEAR relationship does high temp have with total?
#### positive

#### what type of LINEAR relationship does low temp have with total?
#### positive


#### is high temp (on its own) a statistically significant predictor of 
#### the total bike crossing?
reg1 = lm(Total ~ High.Temp.F, data = df)
summary(reg1)

#### is low temp (on its own) a statistically significant predictor of 
#### the total bike crossing?
reg2 = lm(Total ~ Low_Temp_F, data = df)
summary(reg2)

## How correlated are the two predictors?
cor(df$High.Temp.F, df$Low_Temp_F)

## MLR using both predictors
reg3 = lm(Total ~ High.Temp.F + Low_Temp_F, data = df)
summary(reg3)

## INTEPRETATIONS
#### Slope for High Temp
###### As high temp increases 1F, we estimate the number of crossings 
###### to increase by 523.79 holding the low temp constant

#### Slope for Low Temp
###### As Low temp increases 1F, we estimate the number of crossings 
###### to decrease by 218.96  holding the high temp constant


## 2-variable + y would make a 3D plot
install.packages('car')
install.packages('rgl')  ## 
library(rgl)
library(car)

scatter3d(Total ~ High.Temp.F + Low_Temp_F, data = df)

## the variance (std errors) of the estimates get inflated (bigger)
vif(reg3) ## variance inflation factor
## the variance (std error) of High.Temp.F was inflated 3.11
## the variance (std error) of Low_Temp_F was inflated 3.11


