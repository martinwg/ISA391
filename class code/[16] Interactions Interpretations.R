## INTERACTIONS (interpretation)

df = read.csv('https://raw.githubusercontent.com/martinwg/ISA391/refs/heads/main/data/CeoCompensation.csv',
              stringsAsFactors = T)

head(df)


## 1st-order (no interactions, no higher-order)
## y = COMP (thousands)
## x1 = EXPER (years)
## x2 = SALES (in millions)

reg1 = lm(COMP ~ EXPER + SALES, data = df)
summary(reg1)
anova(reg1)


## 3D PLOT OF THE RELATIONSHIP
library(car)
library(rgl)
scatter3d(COMP ~ EXPER + SALES, data = df)


## model with interaction
options(scipen = 999)
reg2 = lm(COMP ~ EXPER + SALES + EXPER:SALES, data = df)
summary(reg2)


## EXPER vs COMP
plot(df$EXPER, df$COMP)
abline(lm(COMP ~ EXPER, data = df), col = "red")

## package to plot interactions
library(sjPlot)
plot_model(reg2, type = "int")

## interpretations

## effect of exper on comp
## As experience increases by 1 year,
## the estimated compensation CHANGES by 0.990161 + 0.007667*SALES

## The effect of experience on compensation depends on the sales
#### e.g., a small company with 10 sales
#### then for every year of extra on experience on the CEO,
#### compensation will increase on average 1.066831







