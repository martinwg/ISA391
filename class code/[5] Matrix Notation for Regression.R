## Read the Analyst Data
## MATRIX NOTATION


df = read.csv('https://raw.githubusercontent.com/martinwg/ISA391/refs/heads/main/data/Analyst_SalaryData.csv',
              stringsAsFactors = T)

## MODEL 1
options(scipen = 999)

reg1 = lm(Salary ~ YearsExperience, data = df)
summary(reg1)
anova(reg1)
## SSE (sums of squared error)

## MODEL 2
reg2 = lm(Salary~ Age, data = df)
summary(reg2)
anova(reg2)


## MODEL 3
reg3 = lm(Salary ~ YearsExperience + Age, data = df)
summary(reg3)
anova(reg3)


## vector
y = df$Salary

## matrix
#### Design (model) matrix
#### X = [1, YearsExperience, Age]
X = model.matrix(reg3)


## 1) dimensions
dim(X)


## 2) transpose (swap rows with columns)
t(X)
dim(t(X))

## 3) Operations
2*X ## scalar multiplication

## For matrix multiplication we use %*%
b = c(1,2,3)  ## 3x1

## X(30x3) b(3x1)  (Good) Result is 30x1
X %*% b

d = c(1,2,3,4)
X %*% d ## X(30x3) b(4x1)  (Bad) Non-conformable


## 4) Independence of Matrices
#### if the matrix is bad (not full rank, singular) then det(A) = 0, and the rank(A) < # cols


## 5) Inverse of a matrix
#### we need the matrix to be square (# rows = # cols)
dim(t(X))
dim(X)

XTX = t(X) %*% X
## it is square (3x3)
dim(XTX)

## inverse function in R is solve()
solve(XTX)

## Create months
df$MonthsExperience = df$YearsExperience*12
df

reg4 = lm(Salary ~ YearsExperience + Age + MonthsExperience, data = df)
summary(reg4)
anova(reg4)

X1 = model.matrix(reg4)
X1
solve(t(X1) %*% X1)


## PARAMETER ESTIMATES IN REGRESSION ARE OBTAINED USING (X'X)^-1  (X'y)
summary(reg3)

beta = solve(t(X) %*% X)  %*% (t(X) %*% y)
beta
