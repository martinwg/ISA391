## Introduction to R
#### Rscripts are the files that save R code


x = 5
normal = rnorm(100)

## Case sensitive
X = 10

## Basic operations: +, -, *
x1 = 10
x2 = 5
x1*x2

## Built-in function

## concatenate: c()
sal = c(64, 70, 55, 80)

## mean
mean(sal)

#### ctl + run (runs the line)

## standard deviation
sd(sal)


## DATA TYPES

#### Numeric (2, 2.4, 10)
x = 10.1
class(x)

#### Character (strings)
course = "Regression"
class(course)

#### Logical
freshman = TRUE 
class(freshman)
junior = F
class(junior)

#### Vector (not a type but contains multiple var types)
gpa = c(3.5, 4.0, 2.9)
class(gpa)

gpa2 = c(3.5, 4.0, "Not Available")
class(gpa2)

gpa2[1]  ## first value of gpa2 (indexing)
gpa[3]   ## 3rd value of gpa
gpa[-1]  ## remove first value of gpa

normal[10:20]    ## from value 10 to value 20 (slicing - indexing)

#### Matrix
A = matrix(c(1,2,3,4,5,6), nrow = 2, ncol = 3, byrow = T)
A

###### have double indexing [rows, cols]
A[2,2] ## 2nd row, 2nd col
A[1,3] ## 1st row, 3rd col

class(A)

## DataFrames can contain different types
df = data.frame(
  sal = c(50, 64, 67, 78),
  exp = c(1, 2, 8, 7),
  class = c("FR", "SO", "SR", "JR")
)

df[1,3]  ## class of the first student
df[,2]     ## only experience
df[3,]

## what is the average sal
mean(df[,1])
mean(df$sal)

















