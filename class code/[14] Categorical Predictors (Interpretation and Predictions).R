## WORKING WITH CATEGORICAL PREDICTORS
#### Read data

df = read.csv('https://raw.githubusercontent.com/martinwg/ISA391/refs/heads/main/data/coffee_shop_sales.csv',
              stringsAsFactors = T)

head(df)


##   y = TotalSpent
#### x = the rest of the predictors (except VisitID)

## Delete the VisitID variable
df$VisitID = NULL


## CHECK VARIABLE TYPES
str(df)


## Numeric
reg1 = lm(TotalSpent ~ Age + VisitDurationMin + TimeOfDay   , data = df)
summary(reg1)

## Dummy only has the values 0 and 1 (nothing else)
library(rgl)
library(car)
scatter3d(TotalSpent ~ Age + VisitDurationMin | TimeOfDay, data = df )

## Suppose your alpha level = 0.1
#### do you drop TimeOfDay?
#### if AT LEAST ONE level is significant, you want the keep the whole variable 


### PREDICTIONS
#### Age = 21
#### VisitDuration = 20
#### Afternoon
#### What is the predicted total spent?

8.154987 + -0.006898*21 + 0.071978*20 + 0.457869*0 +  0.305961*0

### PREDICTIONS
#### Age = 21
#### VisitDuration = 20
#### Evening

8.154987 + -0.006898*21 + 0.071978*20 +0.457869*


#### common wrong-variable are dollar-based variables

## NUMBER OF LEVELS
#### important to determine the number of dummy variables created
#### we need to be careful of variables with many levels
#### e.g., Suppose VisitID = 'aa2456', you would have 999 dummy variables
#### nlevels shows the number of levels of categorical variable


nlevels(df$DrinkType) ## 4 different drinktypes (3 dummy variables)

## levels() shows the different levels order alphabetically
#### the first level is automatically assigned as the "reference", "base"
levels(df$DrinkType)


## What is the ref for TimeOfDay?
levels(df$TimeOfDay)
## "Afternoon" is the ref variable


## What if we wanted to compare TotalSpent against the sales in the morning?
#### We need to change the ref
df$TimeOfDay = relevel(df$TimeOfDay, ref = "Morning")


#### VARIABLE LoyaltyMember (2 levels) - {"No": reference , "Yes": create dummy)
#### R (if variable is factor)
#### LoyaltyMemberYes = {1: yes, 0: Anything else}

reg1 = lm(TotalSpent ~ LoyaltyMember, data = df)
summary(reg1)

## loyalty members spend on average more (0.9953) than non-members (statistically significant) 

## Interpretation of Estimates for Dummy variables
#### 0.9953
#### On average loyalty members spend 0.9953 more than non-member 

### TimeofDay (3 levels) - "Morning" (ref)   "Afternoon" (dummy) "Evening" (dummy)
### TimeofDayAfternoon = {1: afternoon, 0: not the afternoon}
### TimeofDayEvening =   {1: evening  , 0: not the evening}
levels(df$TimeOfDay)
reg2 = lm(TotalSpent ~ TimeOfDay, data = df)
summary(reg2)


## T or (F)**** Customers who go to the coffeshop in the afternoon spend -$0.3201
#### Customers who go to the coffeshop in the afternoon spend 0.32 less than customers who go in the morning

### which customers spend on average the most?
##### Evening Customers

### is the difference in dollars spent in the evening compared to the morning statistically significant?
