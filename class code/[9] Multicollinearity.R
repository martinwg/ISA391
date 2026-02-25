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
# install.packages('car')
# install.packages('rgl')  ## XQuartz
library(rgl)
library(car)

scatter3d(Total ~ High.Temp.F + Low_Temp_F, data = df, fit = "quadratic")

## the variance (std errors) of the estimates get inflated (bigger)
vif(reg3) ## variance inflation factor
## the variance (std error) of High.Temp.F was inflated 3.11
## the variance (std error) of Low_Temp_F was inflated 3.11


## Create a new variable High.Temp.C
df$High.Temp.C = (df$High.Temp.F - 32) / 1.8

## correlation between C and F is 1
cor(df$High.Temp.F, df$High.Temp.C)

## MLR
reg4 = lm(Total ~ ., data = df)
summary(reg4)

### The reason is that we CANNOT calculate (X'X)^-1
### b =  (X'X)^-1 (X'y)
X = model.matrix(reg4)

solve(t(X) %*% X)


## determinant
#### to get the inverse matrix every value gets divided by determinant
#### determinant is zero when the two predictors are perfectly correlated


## Delete the High.Temp.C
df$High.Temp.C = NULL


## REGRESSION 
final_reg = lm(Total ~ High.Temp.F + Low_Temp_F , data = df)
summary(final_reg)

## because High Temp and Low Temp are correlated
## the std errors of the estimates might be inflated
#### is that a problem? We can tolerate if they have been inflated by
#### moderate amount, but large inflation causes issues with p-values
vif(final_reg)
## estimates have been inflated by a factor 3.11
## if vif > 10, we have to check p-values 


## VIF CALCULATIONS
#### High.Temp.F
###### on the background
###### we assume y = High.Temp.F and x = Low_Temp_F 
###### we get the R2
###### vif_high.temp = 1 / (1 - R2)
vif_reg1 = lm(High.Temp.F ~ Low_Temp_F, data = df)
summary(vif_reg1)  ## R2 is 0.6787
vif_high.temp = 1 / (1 - 0.6787)
vif_high.temp

## If VIF > 10, or if cor(x1, x2) > |.9| then high multicollinearity



### ANOVA table
### Sum of squares
### SST
### SSR
### SSE
anova(final_reg)

## what is SST (sum of squares total)?
SST = SSR + SSE

## what is SSE (sum of squares error)?
SSE = 2608511275 

## What is SSR (Sum of squares due to regression)?
## Total SSR
SSR = 3581847670 + 291920982

## What is R2
R2 = SSR / SST
R2

## What is the SSR of high temp?
## 3581847670
#### This is the explained variation of the variable high temp

## What is the SSR of Low temp?
## 291920982
#### This is the ADDITIONAL explained variation contributed by low temp
#### on top of the contribution of high temp







