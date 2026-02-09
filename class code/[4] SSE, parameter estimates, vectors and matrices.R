## Introduction to Linear Regression
#### Goal: How to fit a first-order model

## Read the data
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA391/refs/heads/main/data/Analyst_SalaryData.csv',
              stringsAsFactors = T)

## head
head(df)

## fit a 1st-order model (no higher-order)
### y = Salary
### x = YearsExperience

#### TRUE MODEL
##### Salary = B0 + B1 Experience + E (y = B0 + B1x + E)
#### ESTIMATED MODEL
##### Estimated Salary = b0 + b1 Experience  (yhat = b0 + b1x)
## n = 30


## (1) if possible, plot relationship(s)
plot(df$YearsExperience, df$Salary, main = "Scatter Plot of Analyst Salaries")


## (2) fit model
reg1 = lm(Salary ~ YearsExperience, data = df)
summary(reg1)


## b0: 25792.2 (if years of experience is zero, we estimate the salary to be $25792.2)
## b1: 9450.0 (if experience increases by 1 year, the estimated salary increases by $9450.0)

## Plot the relationship (if 1 single predictor)
plot(df$YearsExperience, df$Salary, main = "Scatter Plot of Analyst Salaries")
abline(reg1, col = "red", lwd = 3)



## HOW GOOD IS THE MODEL?
#### SSE is a good metric to check (sums of squared errors)
#### you can get it like this: sum(reg1$residuals^2)  
#### we prefer to look at the ANOVA (Analysis of variance) Table
options(scipen = 999) ## get rid of e+08 notation
summary(reg1)
anova(reg1)

#### Predicted vs True values of y
#### yhats are called fitted.values
yhat = reg1$fitted.values  ## predictions
y = df$Salary              ## true values of y   

#### Residuals are called residuals or errors
reg1$residuals
y - yhat ## should give the same values as reg1$residuals

## Sums of the residuals
sum(reg1$residuals)



## MATRIX NOTATION
#### Way to represent the data more compactly

#### vectors
###### values for a single variable stacked in a row or a column
x1 = c(1,2,3,4,5)
y = df$Salary ## y is a vector


#### matrices
###### rectangular arrays of numbers
###### vectors concatenated into columns or rowsuifgc



