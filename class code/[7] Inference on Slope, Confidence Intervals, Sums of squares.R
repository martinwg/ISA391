## Inference on the Slope (Beta1)
## C.I. on the Slope (Beta1)
## correlation, R2
## Sums of Squares; SST = SSR + SSE
## Point Estimates and Confidence/prediction intervals

df = read.csv('https://raw.githubusercontent.com/martinwg/ISA391/refs/heads/main/data/college_scorecard.csv',
              stringsAsFactors = T)

head(df)

## omitted NAs
df = na.omit(df)


## kept only two variables: 
df = df[, c("COSTT4_A", "MD_EARN_WNE_P10")]


## plot
plot(df$COSTT4_A, df$MD_EARN_WNE_P10)


## Earn = B0 + B1 Cost + E
## Estimated Earn = b0 + b1 Cost 
#### n = 1711
options(scipen = 999)
reg1 = lm(MD_EARN_WNE_P10 ~ COSTT4_A, data = df)
summary(reg1)


### b1 =  0.40993 
#### s_b1 =  0.01786
#### t = b1 / s_b1 = 22.95  (b1 is 22.95 std errors away from zero)
#### df = n - (k+1) ------- 1711 - (1+1) = 1709

## Hypothesis on the SLOPE (B1)
## H0: B1 = 0   (true slope is zero)
## HA: B1 != 0  (true slope is NOT zero)

## p-value
#### probability that we obtain the t-statistic as extreme as the one we got
#### given that the null hypothesis is TRUE
#### P(t > 22.95 | H0)

abline(reg1, col = "red", lwd = 4)



### CONFIDENCE INTERVAL ON B1
confint(reg1, level = 0.95)  ## 95% conf. interval on B1
### We are 95% confident that B1 is between 0.37 and 0.44
confint(reg1, level = 0.99)
### We are 99% confident that B1 is between 0.36 and 0.46


## correlation
cor(df$COSTT4_A, df$MD_EARN_WNE_P10)
#### moderate


## Sums of squares
## SST (total)
## SSE (unexplained)
## SSR (explained)
anova(reg1)

SSE = 307638449974
SSR = 94796418849  ## explained by the cost of college
SST = SSR + SSE
SST  ## total variability of Earnings

## this is how SST is calculated (total variability of Earnings)
sum ((df$MD_EARN_WNE_P10 - mean(df$MD_EARN_WNE_P10))^2)

## R2 = 0.2356
### We can explain 23.56% of the variability in Earnings by using Cost
### of college as predictor

## how to make predictions
#### point estimates 
student1 = data.frame(COSTT4_A = 50000)

prediction = predict(reg1, student1)
prediction

predict(reg1, data.frame(COSTT4_A = 50000))

## CONFIDENCE INTERVAL ON THE MEAN (AVERAGE EARNINGS FOR STUDENTS WITH COST = 50000)
predict(reg1, data.frame(COSTT4_A = 50000), interval = "confidence", level = 0.95)
## we are 95% confident that the AVERAGE SALARY of students with cost of college = 50k
## is between 56546.19 and 58029.56


## PREDICTION INTERVAL ON AN INDIVIDUAL
predict(reg1, data.frame(COSTT4_A = 50000), interval = "prediction", level = 0.95)
## we are 95% confident that this student (cost of college = 50k) will earn
## between 30962.32 and 83613.42

