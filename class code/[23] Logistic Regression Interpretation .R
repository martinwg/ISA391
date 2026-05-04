## LOGISTIC REGRESSION (INTERPRETATION OF ESTIMATES)

df = read.csv('https://raw.githubusercontent.com/martinwg/ISA391/refs/heads/main/data/fraud_data.csv',
              stringsAsFactors = T)

## say x = transaction amount
### y = {1: fraud, 0: non-fraud}
plot(df$transaction_amount, df$fraud)

## Logistic Regression
reg1 = glm(fraud ~ transaction_amount, data = df)
summary(reg1)

# LOG ODDS

## We are predicting the Log(odds) of the transaction being a fraud

## what are the log(odds) of fraud is the transaction $ is $100?
0.0667987 + 0.0001397*100 = 0.0807687 ## log(odds) of fraud

predict(reg1, data.frame(transaction_amount = 100))
## this the log(odds) as well

## if the log(odds) of fraud increases, the probability of fraud also increases


# PROBABILITY
## we have to the link function e^{logodds} / (1 + e^{logodds})

## for transaction_amount = $100, the log(odds) of fraud 0.0807687

exp(0.0807687) / (1 + exp(0.0807687)) =  0.52 ## probability of fraud


## ODDS
#### prob(something happens) / (1 - prob(something happens))

p = 0.5
odds = p / (1-p)
odds


## e.g. prob of transaction being a fraud is 0.52
p = 0.52
odds = p / (1-p)
odds

## if I have Log(ODDS)  then exp(Log(odds)) = Odds
## if I have p, then odds = p / (1-p)
## if I have the odds, then I can get the Log(odds)


#### PREDICTIVE MODEL OF FRAUD

## 1) data engineering
colSums(is.na(df)) ## OK
df$card_present = NULL


## 2) split the data into training / test
set.seed(391)
trainIndex = sample(1:nrow(df), size = round(0.7*nrow(df)))
df.train = df[trainIndex,]
df.test = df[-trainIndex,]


## 3) variable selection and build models
#### AIC (gives more variables) - 2
#### BIC (fewer variables) - log(nrow(df.train))
#### forward, backward, both

## stepwise (both) with BIC
null = glm(fraud ~ 1, data = df.train)
full = glm(fraud ~ ., data = df.train)
step_reg = step(null, scope = list(lower = null, upper = full), direction = "both",
                trace = 2, k = log(nrow(df.train)))
summary(step_reg)

## forward reg with AIC
null = glm(fraud ~ 1, data = df.train)
full = glm(fraud ~ ., data = df.train)
forward_reg = step(null, scope = list(lower = null, upper = full), direction = "forward",
                trace = 2, k = 2)
summary(forward_reg)

## 4) check performance on a new data set (test)
logodds = predict(step_reg, df.test)
logodds

prob = exp(logodds) / (1 + exp(logodds))


## INTERPRETATION
# new_device                 0.0807594
## for a transaction with a new device, the log(odds) of fraud increase by 0.0807594
## holding other variables constant

## for a transaction with a new device, the odds of fraud increase by A FACTOR OF 1.08411
## holding other variables constant




## 5) out-of-sample data set

















