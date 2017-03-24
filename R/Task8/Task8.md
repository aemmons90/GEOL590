# Task 8

##Introduction:
The following code was written in completion of Task08. The purpose of this task was to learn how to write functions. 

##Function 1

###Functions and error handling: 
The goal was to write a function that fulfills the following criteria:
  It should be tidyverse compatible (i.e., the first argument must be a data frame)
  It should add two arbitrary columns of the data frame (specified by the user) and put them in a new column of that data frame, with the name of the new column specified by the user
  
Error messages should also be included:
It should throw an informative warning if any invalid arguments are provided.   Invalid arguments might include:
  The first argument is not a data frame
  Less than two valid columns are specified to add (e.g., one or both of the column names isn't in the supplied data frame)
  The columns specified are not numeric, and therefore can't be added - use tryCatch() for this
  If the columns to add aren't valid but the new column name is, the function should create a column of NA values


```r
#using the nycflights/weather dataset, which is a tibble data set.
x<- nycflights13::weather

#This function takes 4 arguments, the first being the dataframe and the last three as columns
col_add <- function(df, i, j, k){ 
  
#This sets the warning if the first argument is not a data frame.
  if(is.data.frame(df) != TRUE) stop("The first argument is not a data frame") 

#This creates a warning if the column specified does not belong to the dataframe used in the function
  if(is.data.frame(df[[i]]) != TRUE | is.data.frame(df[[j]]) !=TRUE) warning("i or j does not belong to df")

#sums columns i and j and creates a new column "k", which can be named when the function is called  
  df[[k]] <- (df[[i]] + df[[j]]) 
  
#use trycatch() if the columns to add aren't valid but the new column name is, the function should create a column of NA values
#tryCatch(is.data.frame(), error=function(cond) FALSE) #Not sure how to use trycatch()

#returns the original data frame.
  return(df) 
}

#Calling the function
col_add(x, "humid", "precip", "mynewcol") 
```

```
## Warning in col_add(x, "humid", "precip", "mynewcol"): i or j does not
## belong to df
```

```
## # A tibble: 26,130 × 16
##    origin  year month   day  hour  temp  dewp humid wind_dir wind_speed
##     <chr> <dbl> <dbl> <int> <int> <dbl> <dbl> <dbl>    <dbl>      <dbl>
## 1     EWR  2013     1     1     0 37.04 21.92 53.97      230   10.35702
## 2     EWR  2013     1     1     1 37.04 21.92 53.97      230   13.80936
## 3     EWR  2013     1     1     2 37.94 21.92 52.09      230   12.65858
## 4     EWR  2013     1     1     3 37.94 23.00 54.51      230   13.80936
## 5     EWR  2013     1     1     4 37.94 24.08 57.04      240   14.96014
## 6     EWR  2013     1     1     6 39.02 26.06 59.37      270   10.35702
## 7     EWR  2013     1     1     7 39.02 26.96 61.63      250    8.05546
## 8     EWR  2013     1     1     8 39.02 28.04 64.43      240   11.50780
## 9     EWR  2013     1     1     9 39.92 28.04 62.21      250   12.65858
## 10    EWR  2013     1     1    10 39.02 28.04 64.43      260   12.65858
## # ... with 26,120 more rows, and 6 more variables: wind_gust <dbl>,
## #   precip <dbl>, pressure <dbl>, visib <dbl>, time_hour <dttm>,
## #   mynewcol <dbl>
```
##Function 2

###Writing a for loop in R
Write a function named that uses a for loop to calculate the sum of the elements of a vector, which is passed as an argument (i.e., it should do the same thing that sum() does with vectors). your_fun(1:10^4) should return 50005000.

```r
#Create a vector to use to test the function
y<- (1:10^4)

#create a function named "vsum"
vsum <- function(a){
#This creates a loop for each element in an object a
  for(i in a){
#This defines that i is an element of a
  if(is.element(i, a) ==TRUE)
#This takes the sum of the vector a, or each element in the vector
  b<-sum(a)}
print(b)
}
#Calling the function
vsum(y)
```

```
## [1] 50005000
```
###Loop Step 2
The goal was to use the microbenchmark::microbenchmark function to compare the performace of the above function to that of sum in adding up the elements of the vector 1:10^4. The benchmarking code should look something like:


```r
library("microbenchmark")
```

```
## Warning: package 'microbenchmark' was built under R version 3.3.3
```



```r
test.vec <- 1:10^4
microbenchmark::microbenchmark(
    vsum(test.vec),
    sum(test.vec)
    )
```

```
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
## [1] 50005000
```

```
## Unit: microseconds
##            expr        min          lq         mean     median         uq
##  vsum(test.vec) 362268.925 406324.2520 576551.08764 542908.163 688360.893
##   sum(test.vec)      6.316     10.6595     16.95562     14.607     23.094
##          max neval cld
##  1103272.501   100   b
##       37.503   100  a
```
### Is there a difference?
Yes, there was a difference between my loop function vsum() and sum(). I have no idea why. 
