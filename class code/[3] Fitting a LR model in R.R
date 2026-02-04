## Practice with DataFrames

df1 = read.csv("https://raw.githubusercontent.com/martinwg/ISA391/refs/heads/main/data/cardata.csv",
               stringsAsFactors = T)

head(df1)


## subsetting variables
#### histogram of the price
hist(df1$price)


#### scatter plot
plot(df1$horsepower, df1$price, main = "Scatter plot of HP vs Price",
     xlab = "HP", ylab = "Price in $")


#### Bar chart
barplot(table(df1$drivewheel))

#### df1mod citympg, highwaympg, price
df1mod = df1[ , 24:26 ]
head(df1mod)

df1mod = df1[, c(24,25,26)]
head(df1mod)

df1mod = df1[, c("citympg", "highwaympg", "price")]
head(df1mod)

## subsetting observations
#### cars with 4wd drivewheel
df1[ df1$drivewheel == "4wd", ]

#### condition: (<, >, <=, >=, ==, != )
df1$price > 10000
df1$fueltype == "diesel"
df1$drivewheel == "4wd"
df1$drivewheel == "4wd" & df1$fueltype == "gas"
df1$drivewheel == "4wd" | df1$cylindernumber == "eight" 



## FITTING A LINEAR REGRESSION MODEL IN R
#### x = citympg
#### y = price

## 1) is a first-order model appropriate?
#### is the relationship linear? NO, A SECOND-ORDER MODEL MIGHT BE BETTER
plot(df1mod$citympg, df1mod$price)

## 2) fit a 1st-order model (MAYBE MISSED FIRST PART)
## lm(y ~ x, data = df) - linear model
reg1 = lm(price ~ citympg, data = df1mod)
summary(reg1)

#### TRUE MODEL
##### price = B0 + B1 citympg + E
#### ESTIMATED (n = 205)
##### estimated price = 34395.44 - 837.40*citympg  

## PLOT THE ESTIMATED LINE
plot(df1mod$citympg, df1mod$price)
abline(reg1, col = "red", lwd = 3)






