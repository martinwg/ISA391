## Exam 1 Practice

df = read.csv('https://raw.githubusercontent.com/martinwg/ISA391/refs/heads/main/data/customer_lifetime_value.csv',
              stringsAsFactors = T)

head(df)

## scatter plot
plot(df$Avg_Monthly_Spend, df$CLV_Target)


## REGRESSION
#### first-order linear model
reg1 = lm(CLV_Target ~ Avg_Monthly_Spend , data = df)
summary(reg1)


#### anova (sums of squares)
options(scipen = 999)
anova(reg1)


#### assumptions plots
plot(reg1)

### 1) x = fitted, y = residuals
### plot(reg1$fitted, reg1$residuals)
### 2) Q-Q plot
### 3) x= fitted, y = std residuals
### 4) leverage


## Reg2 
reg1 = lm(CLV_Target ~ . - Support_Calls        , data = df)
summary(reg1)
anova(reg1)