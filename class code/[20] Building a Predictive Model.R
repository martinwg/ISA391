## BUILDING A PREDICTIVE MODEL
#### Goals: to predict unseen data accurately


### READ DATA
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA391/refs/heads/main/data/streaming_music_popularity.csv',
              stringsAsFactors = T)

head(df)


### 1) PRE-PROCESSING
#### remove uninformative variables (IDs, names, ...)
#### remove variables with too many levels (combine levels for those you still want to use)
#### work with missing values (imputation or remove observations with missings)


colSums(is.na(df))  ## no missing values
levels(df$Genre)    ## 8 genres (OK)
df$SongID = NULL    ## removing uninformative variables


### 2) SPLIT THE DATA INTO TRAINING / TEST
#### 70/30 or 80/20

set.seed(391)
trainIndex = sample(1:nrow(df), size = round(0.7*nrow(df))  )
df.train = df[trainIndex, ]
df.test  = df[-trainIndex, ]


### 3) BUILD MODELS (COMPETING) ON TRAINING DATA SET


# --------------------------------------
# model1: simple model
# --------------------------------------

model1 = lm(PopularityScore ~ ., data = df.train)
summary(model1)


## -------------------------------------
## model2: higher-order
# --------------------------------------

model2 = lm(PopularityScore ~ PlaylistPlacements + ArtistFollowers_K + PriorArtistPopularity +
              TikTokMentions_K + Genre + ReleaseMonth + MajorLabel + MonthlyStreams_M +
              I(MonthlyStreams_M^2), data = df.train)
summary(model2)

## -------------------------------------
## model3: your chocice
## ------------------------------------




### 4) PERFORMANCE METRICS
#### MSE, MAE, R2, AIC, BIC

##### e.g., MSE for model 1 and model 2
library(Metrics)

##  Prediction for Model1
yhat1  = predict(model1, newdata = df.test)

##  Prediction for Model2
yhat2 = predict(model2, newdata = df.test)

##  Prediction for Model3


mse(df.test$PopularityScore, yhat1) ## 78.949 for model1
mse(df.test$PopularityScore, yhat2) ## 68.516 for model2
mse(df.test$PopularityScore, yhat2) ##   


## function to get all metrics together
model_metrics = function(actual, predicted, k){
  n = length(actual)
  SSE = sum((actual - predicted)^2)
  MSE = SSE / n
  RMSE = sqrt(MSE)
  MAE = mean(abs(actual - predicted))
  SST = sum((actual - mean(actual))^2)
  R2 = 1 - (SSE / SST)
  AIC = n*log(SSE/n) + 2*k
  BIC = n*log(SSE/n) + log(n)*k
  
  return(data.frame(
    MSE = MSE,
    RMSE = RMSE,
    R2 = R2,
    MAE = MAE,
    AIC = AIC,
    BIC = BIC,
    k = k
  ))
}

## model1
model_metrics(df.test$PopularityScore, yhat1, 35)

## model2
model_metrics(df.test$PopularityScore, yhat2, 25)

## your model


### The models have to be generalizable (they are stable across different data sets)
### the more model df, the more likely that it overfits (not stable)
### higher-order terms are tricky on extrapolation 
### What can we do with too many predictors (200 variables)?
##### Variable selection techniques -- Stepwise, Forward, Backward 
### Which models should I try? Any way we can automate  quadratic, interactions??
##### best subsets (can try many models)




