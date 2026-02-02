## Reading Data into R

#### 1) Reading data from online sources
##### read cardata.csv from github page

df = read.csv("https://raw.githubusercontent.com/martinwg/ISA391/refs/heads/main/data/cardata.csv",
              stringsAsFactors = T)


## mean price of the cars
#### indexing - know col number
mean(df[ ,26])
#### object - $variablename
mean(df$price)


## read Credit_data.csv
#### name it df1
df1 = read.csv("https://raw.githubusercontent.com/martinwg/ISA391/refs/heads/main/data/Credit_data.csv",
               stringsAsFactors = T)


## read WPOWER50.txt
df2 = read.table("https://raw.githubusercontent.com/martinwg/ISA391/refs/heads/main/data/WPOWER50.txt",
                 sep = "\t", header = T, stringsAsFactors = T)


## Reading data from your computer
#### 1) complete path
df3 = read.csv("C:\Users\martinwg\Downloads\GFCLOCKS.csv")
#### 2) working directory
##### Click Session - Set Working Directory - Choose Directory - Select FOLDER (not file)
df4 = read.csv("Cars.csv", stringsAsFactors = T)


## Print the first 6 observations of df
head(df)
head(df, 4)
tail(df)

## Inspect variable types
str(df)  ## structure

## data() prints preloaded datasets
data()
AirPassengers

## packages (modules)
library(nnet) ## loads the package
## install.packages("mlbench") to install a package
#### install mlbench
data("BostonHousing") ## to load the data use data()


## Subsetting

## print cars price less 6000
df[df$price < 6000 & df$fueltype == "gas", ]





