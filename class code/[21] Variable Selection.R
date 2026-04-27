## VARIABLE SELECTION

#### Goal is to reduce the number of predictors to a more manageable number

## READ DATA
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA391/refs/heads/main/data/customer_revenue.csv',
              stringsAsFactors = T)
df

#### Structure
str(df)


## DATA ENGINEERING

#### missing values (we have to impute before variable  selection)
colSums(is.na(df))


## DATA SPLIT (0.7 training / 0.3 test)
set.seed(391)
trainIndex = sample(1:nrow(df), size = round(0.7*nrow(df)) )
df.train = df[trainIndex, ]
df.test = df[-trainIndex, ]


## MODELING (not feasible)
reg1 = lm(annual_revenue ~., data = df.train)
summary(reg1)


## 1) BEST SUBSETS 
#### better used when model df (k) is not too large < 50
# install.packages('leaps')
library(leaps)

reg_s = regsubsets(annual_revenue ~.,
                   data = df.train,
                   nbest = 1,
                   nvmax = 15)

summary(reg_s)

reg_s_summary = summary(reg_s)


#################################################################
# best model according to R-squared
#################################################################

best_adjr2 = which.max(reg_s_summary$adjr2)
reg_s_summary$outmat[best_adjr2,]  ## this will show you which variables are selected as most important according to adjR2
## 8 variables are selected

#################################################################
# best model according to BIC
#################################################################

best_bic = which.min(reg_s_summary$bic)
reg_s_summary$outmat[best_bic,]  ## this will show you which variables are selected as most important according to adjR2
## 6 variables

#################################################################
# best model according to C
#################################################################

best_CP = which.min(reg_s_summary$cp)
reg_s_summary$outmat[best_CP,]  ## this will show you which variables are selected as most important according to adjR2
## 8 variables


## PLOTS
plot(reg_s_summary$adjr2, type = "b", main = "Best subsets: Adjusted R Squared")

plot(reg_s_summary$bic, type = "b", main = "Best subsets: BIC")

plot(reg_s_summary$cp, type = "b", main = "Best subsets: Cp")

## SELECT BIC MODEL

options(scipen = 999)
best_bic = lm(annual_revenue ~ income + num_orders  + return_rate + 
                days_since_last_purchase + email_click_rate + 
                loyalty_member + website_visits, data = df.train)
summary(best_bic)



## 2) BACKWARD VARIABLE SELECTION
null = lm(annual_revenue ~ 1, data = df.train)
full = lm(annual_revenue ~ ., data = df.train)

reg_back = step(full, scope = list(lower = null, upper = full), direction = "backward", trace = 2, k = 2) ## AIC

summary(reg_back)




## 2) BACKWARD VARIABLE SELECTION
null = lm(annual_revenue ~ 1, data = df.train)
full = lm(annual_revenue ~ ., data = df.train)

reg_forward = step(null, scope = list(lower = null, upper = full), direction = "forward", trace = 2, k = 2) ## AIC

summary(reg_forward)


## 3) BOTH WAYS VARIABLE SELECTION
null = lm(annual_revenue ~ 1, data = df.train)
full = lm(annual_revenue ~ ., data = df.train)

reg_both = step(null, scope = list(lower = null, upper = full), direction = "both", trace = 2, k = log(700)) ## BIC

summary(reg_both)
