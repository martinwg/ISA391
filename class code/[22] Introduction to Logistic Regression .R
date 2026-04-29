## INTRODUCTION TO LOGISTIC REGRESSION

#### Y = BINARY VARIABLE (CATEGORICAL)
#### e.g., y = {fraud, non-fraud}, y = {patient improved, did not improve}
#### we need to encode to {0, 1}, where 1 is the class of interest. Fraud = 1, Respond = 1

#### Suppose y = {1: Fraud, 0: Not Fraud}
#### x1 = Distance from home
#### yhat = -1 + 0.07 dist 

yhat = -1 + 0.07*100 
yhat  ## is not constrained to 0 and 1. SO regular regression is not applicable

#### Logit (Logistic) Transformation
#### exp(y) / (1 + exp(y))
#### 1 / (1 + exp(-y))

exp(6) / (1 + exp(6))
1 / (1 + exp(-6))


#### Logit Function
logistic = function(y){
  p = exp(y) / (1 + exp(y))
  return(p)
}


logistic(1.2)
## logistic(y) ---> 1 if y is large + 
## logistic(y) ---> 0 if y is large - 

## FIT LOGISTIC REGRESSION

df = read.csv('https://raw.githubusercontent.com/martinwg/ISA391/refs/heads/main/data/fraud_data.csv',
              stringsAsFactors = T)

head(df)

## x = distance_from_home 
#### larger x, the more likely y = 1 (fraud)

## PLOT (SCATTER)
plot(df$distance_from_home, df$fraud)

## LOGISTIC REGRESSION
lr1 = glm(fraud ~ distance_from_home, data = df, family = "binomial")
summary(lr1)

## + slope means that as distance from home increases, the probability
## of fraud increases

## CANNOT say that as dist increases by 1 mile, prob of fraud increases by 0.01

## PREDICTIONS
#### dist = 5 
yhat = -2.787383 + 0.010471*5
yhat

## -2.735028 is the LOG(ODDS) of fraud

logistic(yhat) ## is the probability that this transaction is a fraud (6.1%)
exp(yhat) / (1 + exp(yhat))



## What are the log(odds) of fraud if the distance from home is 5 miles?
logodds = -2.787383+0.010471*5
logodds

## What is the probability of fraud if the distance from home is 5 miles?
logodds = -2.787383+0.010471*5
logodds


logistic(logodds)

## or

exp(logodds) / (1 + exp(logodds))



## ODDS
#### ratio of probability (happens) over probability (does not happen)

p = 0.1
p / (1 - p)


### What are the odds that a transaction 5 miles a away from is a fraud?

# 1) logodds
# 2) prob = exp(logodds) / (1 + exp(logodds))
# 3) odds = prob / (1 - prob)

# or

# 1) logodds
# 2) odds = exp(logodds)


logodds = -2.787383+0.010471*5
prob = exp(logodds) / (1 + exp(logodds))
odds = prob / (1 - prob)

## the odds of this transaction being a fraud is 0.06489


## Logodds
## Log(odds) = x
## odds = exp(logodds)
exp(logodds)


