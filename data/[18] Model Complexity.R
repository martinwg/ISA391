## MODEL COMPLEXITY

### Read data
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA391/refs/heads/main/data/retail_sales.csv',
              stringsAsFactors = T)

head(df)


#### Complexity is measured by the MODEL DF
#### MODEL DF: refers the number of estimated slopes in the model
#### We want lower complexity
#### Let's call model df: k 

reg1 = lm(Sales ~ Region     , data = df)
summary(reg1)

###  How many model df do following variables contribute? 
###  StoreType: 2 model df  ----  2 dummies (slopes)
###  Price: 1 model df 
###  PromotionType: 3 model df

### If we use these variables:
###  StoreType
###  Price
###  PromotionType
### What is the total model df: 2 + 1 + 3 = 6 model df

### ### If we use these variables:
###  StoreType
###  Price
###  PromotionType
### What is the minimum number of observations needed to estimate the slopes and stats?
### k + 1 = 6 + 1 = 7 obs


### The model df (k) is shown on the F-statistic on the regression output.



### small dataset
df_small = df[1:6, ]
df_small

reg2 = lm(Sales ~ StoreType + Price + PromotionType, data = df_small)
summary(reg2)

##  Regression wih ALL THE predictors predicting Sales
### get the model df (k) - 15 model df
### error df (n - (k+1)) - 984 error df

options(scipen = 999)
reg3 = lm(Sales ~ ., data = df)
summary(reg3)



## Let's reduce the number of levels for the variable season
#### Spring and Fall on average have about the same sales amount
#### Let's combine the two levels together
install.packages ('forcats')
library(forcats)

df$Season = fct_collapse(df$Season, spr_fall = c("Spring", "Fall"),
                                    Summer = c("Summer"),
                                    Winter = c("Winter"))


df$Season



