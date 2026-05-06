### Read the data
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA391/refs/heads/main/data/bank_marketing.csv',
              stringsAsFactors = T)
head(df)


### Delete the variable `Duration`. See reasoning in the variable description (2 pts).
df$duration = NULL

### Combine the levels for the variable month 
### into the following: first_quarter = {jan, feb, mar}, second_quarter = {apr, may, jun}, 
### third_quarter = {jul, aug, sep}, fourth_quarter = {oct, nov, dec} (4 pts)

library(forcats)
df$month = fct_collapse(df$month, 
                        first_quarter = c("jan", "feb", "mar"),
                        second_quarter = c("apr", "may", "jun"), 
                        third_quarter = c("jul", "aug", "sep"),
                        fourth_quarter = c("oct", "nov", "dec"))

levels(df$month)


### For the variable job keep only {admin, management, blue-collar) 
### and set the other levels to "other" (3 pts)
df$job = fct_collapse(df$job, 
                        admin = c("admin."),
                        management = c('management'),
                        "blue-collar" = c("blue-collar"), 
                        other_level = "Other")

levels(df$job)


### Use the random seed 101, and a 70/30 training validation split.  
### Split the data into a training set and a validation set.  
### Print the head of the training set and the validation set (2 pts)

set.seed(101)
trainIndex = sample(1:nrow(df), size = round(0.7*nrow(df)))
df.train = df[trainIndex,]
df.test = df[-trainIndex,]


### Using the training data set, perform stepwise in both directions to find the most important variables (3 pts).

null = glm(deposit ~ 1, data = df.train)  ## smallest model
full = glm(deposit ~ ., data = df.train)  ## biggest model
lr_both = step(null, scope = list(lower = null, upper = full), direction = "both", trace = 2, k = 2) 
summary(lr_both)

## poutcome + housing + contact + month +  loan + marital + campaign + education + balance + age + job


### To the model found in 3. add the quadratic term for `balance`. If `balance` was NOT selected by the stepwise method also add it (4 pts).
lr_both_new = glm(deposit ~ poutcome + housing + contact + month + 
  marital + loan + campaign + education + balance + age + default + 
  day + previous + I(balance^2), data = df.train)
summary(lr_both_new)


### effect of campaign
# - coefficient sign means that the more contacts, the less the likelihood (odds, probability) of responding to the offer

options(scipen = 999)
summary(lr_both_new)

## as the number of contacts increases by 1, the log(odds) of responding to the offer decreases by 0.00413498220749
## as the number of contacts increases by 1, the odds of responding to the offer changes by a factor 
## of exp(-0.00413498220749) = 0.9958736 (multiplied by 0.9958736)


## Interpret the effect of balance (accts balance) in terms of the log(odds) of getting a deposit account (4 pts).

#### TODO


## Create a table with the signs of the coefficients for the variables (4 pts).

#### TODO (you can use the summary())


## Predict the logodds


newdata = data.frame(data.frame(poutcome = "other",  
                                month = "third_quarter",
                                contact ="unknown",
                                housing = "yes",
                                campaign = 10,
                                loan = "yes",
                                marital = "single",
                                balance = 400,
                                default = "no",
                                pdays = 100,
                                previous = 7, 
                                education = "primary",
                                age = 21,
                                day = 21)
)                 
        
predict(lr_both_new, newdata )


## Predict the df.test data set and obtain the accuracy of the test set using the Metrics package (accuracy) (4 pts)

predictions = predict(lr_both_new, df.test) ## log(odds)
## change the prediction to be 0: did not respond, 1: responded

##1) predictions are logodds, so we need to change to prob (prob = exp(predictions) / (1 + exp(predictions)))
prob = exp(predictions) / (1 + exp(predictions))


## You can also the probabilities directly
prob = predict(lr_both_new, df.test, type = "response")


## need to select a cutoff (0.5)
y_pred = predictions > 0.5


install.packages('Metrics')
library(Metrics)
accuracy(df.test$deposit, y_pred)
