## Inference, 
## Sums of squares: SST, SSR, SSE
## R2

df = read.csv('https://raw.githubusercontent.com/martinwg/ISA391/refs/heads/main/data/college_scorecard.csv',
              stringsAsFactors = T)

head(df)


## Select only COSTT4_A , and MD_EARN_WNE_P10
df = df[, c("COSTT4_A", "MD_EARN_WNE_P10")]
head(df)

## We can either omit observations with missing values
## or we can impute (average)
df = na.omit(df)
head(df)


## Scatter plot
plot(df$COSTT4_A, df$MD_EARN_WNE_P10)


## REGRESSION
## TRUE: median_earnings = B0 + B1 Cost + Error
## ESTIMATED: yhat = b0 + b1 X
options(scipen = 999)
reg1 = lm(MD_EARN_WNE_P10 ~ COSTT4_A, data = df)
summary(reg1)
anova(reg1)

## INTERPRETATION IN THE LANGUAGE
#### b0:  We estimate the median earnings to be $30658, when cost is $0
#### b1: As cost of college increases by $1, the estimated median 
#### earnings increase by $0.51


abline(reg1, col = "red", lwd = 4)


### CHECK THE ASSUMPTIONS 

#### 1) mean(E) = 0
e = reg1$residuals
mean(e)

#### 2) var(E) = Sigma^2 (constant)
#### estimate of Sigma^2 is MSE
#### MSE (anova)
anova(reg1)

#### a) look at the scatter plot (see if RMSE is about the same)
#### b) plot residuals (y-axis) vs predicted (x-axis)
plot(reg1$fitted.values, reg1$residuals)

#### 3) E ~ N(0, Sigma^2)
hist(reg1$residuals, breaks = 30)
shapiro.test(reg1$residuals) ## if p-value is small -> NOT NORMAL

## EASIER WAY (Similar JMP)
plot(reg1)
## 1st plot: constant variance assumption plot
## 2nd plot: Q-Q plot (the closer to line the more normal the residuals are)


#### 4) Independence 
#### you would need a time/order variable 
#### NO TIME VARIABLE
#### if we do  plot(time, residuals)

summary(reg1)

