## INTERACTIONS 

#### Read the data
df= read.csv('https://raw.githubusercontent.com/martinwg/ISA391/refs/heads/main/data/pain_dataset.csv',
             stringsAsFactors = T)

head(df)


#### delete participant id
df$participant_id = NULL
head(df)


#### relationships 
plot(df)


## 1st Order Model
#### y = pain level, 
#### x1 = hours sleep
#### x2 = water intake
#### x3 = acetaminophen
#### x4 = group

reg1 = lm(pain_level_after~ hours_sleep  + water_intake_liters  + acetaminophen_mg + group,
          data = df)
summary(reg1)
anova(reg1)


## relevel group
df$group = relevel(df$group, ref = "Non-Caffeine")


reg1 = lm(pain_level_after~ hours_sleep  + acetaminophen_mg + group,
          data = df)
summary(reg1)
anova(reg1)


plot(df$caffeine_mg, df$pain_level_after)
abline(lm(pain_level_after ~ caffeine_mg, data =df ), col = 'red')


## INTERACTION
#### acetaminophen_mg:group
#### creates interaction between the two predictors
#### df$tylenol_coffee = df$acetaminophen_mg * df$group


reg2 = lm(pain_level_after~ hours_sleep  + acetaminophen_mg + group + acetaminophen_mg:group,
          data = df)
summary(reg2)
anova(reg2)


## Interpret
#### What is the effect of acetaminophen on the pain level?

### groupCaffeine = 0 (no caffeine)

##### (for people who did not take caffeine) as acetaminophen increases by 1mg, 
##### then we estimate the pain level to decrease by -0.0013134
##### holding other variables constant 

##### (for people who took caffeine) as acetaminophen increases by 1mg,
##### then we estimate the pain level to decrease by -0.0013134-0.0015315 = -0.0028449
##### holding other variables constant

plot(df$acetaminophen_mg, df$pain_level_after)
abline(lm(pain_level_after ~ acetaminophen_mg, data =df ), col = 'red')


#### sjPlot
install.packages('sjPlot')
library(sjPlot)

reg2 = lm(pain_level_after~ hours_sleep  + acetaminophen_mg + group + acetaminophen_mg:group,
          data = df)
summary(reg2)

### plot interactions
plot_model(reg2, type = "int")


## swap group with caffeine_mg

options(scipen = 999)
reg3 = lm(pain_level_after~ hours_sleep  + acetaminophen_mg + caffeine_mg 
          + acetaminophen_mg:caffeine_mg,
          data = df)
summary(reg3)

###  Interpret the effect of acetaminophen in pain level
#### As acetaminophen increases by 1mg, the estimated pain level will change
#### depending on the level of caffeine_mg 
#### As acetaminophen increases by 1mg, the estimated pain level will change 
#### by -0.001431642 -0.000011222*caffeine_mg holding other variables constant

## e.g. if you took no caffeine. Pain level on average will change by  -0.001431642
## What if I took 100mg of caffeine: Pain level will on average change by -0.002553842
## 






