#Explore vectorization. Explain the differences and the similarities between the following code snippets. What data structure are a, b, and c?
a <- 1
# This is an atomic vector; the type is a "double."
b <- 2
# This is an atomic vector; the type is a "double."
c <- a + b
# This is an atomic vector; the type is a "double." This is the same thing as saying c <- 3.

set.seed(0) # This ensures that 'random' results will be the same for everyone
d <- rnorm(20)
# Function that produces a vector. This is also an atomic vector that contains numerical data between 1 and 20; it is a "double" vector.
e <- rnorm(20)
# Function that produces a vector. This is an atomic vector similar to "d", also a "double."
f <- d + e
# This is still an atomic vector of type "double;" however, each position of the vector is a sum of d+e.

_________________________________________________________________________________________________________________________________________________________________

#In my opinion, R's ability to assign attributes to objects is enormously helpful.
#Name three ways you could use attributes to make data analysis code more reproducible (i.e., easier for yourself and others to understand).
#1: Naming a vector
#2: Attributes such as defining a factor can allow data to be more reproducible for statistical analysis in which groups are compared.
##3: Attributes can be used to make data matrices and arrays to better visualize data?

#Create a vector of length 5, and use the attr function to associate two different attributes to the vector.
x <- 1:5
attr(x, "my_attribute") <- "This is a vector"
attr(x, "my_attribute2") <- "Number of dogs counted"

#AR exercises:
#2.2.2.2 (that is, question 2 in section 2.2.2): "What happens to a factor when you modify its levels?"
f1 <- factor(letters)
levels(f1) <- rev(levels(f1))
## The factor is also modified. In the case of the above code, the letters of the alphabet were reversed for both the levels and the factor.

#2.2.2.3: What does this code do?
f2 <- rev(factor(letters))
#This reversed the letters making up the factor
f3 <- factor(letters, levels = rev(letters))
#This reversed the levels within the factor, which then reversed the letters in the factor

#2.3.1.1: What does `dim` return when applied to a vector, **and why**?
#It results in a "NULL".
#vectors can only have a length.

#2.4.5.1: What attributes does a data frame possess?
# A data frame is composed of equal length vectors.
# It has column names, row names, and length() attributes.
# It has factors and levels.
# Not composed of the same type of data and acts like a list and matrix.

#2.4.5.2: What does `as.matrix()` do when applied to a data frame with columns of different types?
#From the help, it sounds like different vectors will be coerced into vectors of the same type?

#2.4.5.3: Can you have a data frame with 0 rows? What about 0 columns?
#This wouldn't make sense. A data frame with 1 column has a row and vice versa.

______________________________________________________________________________________________________
Simple Operations

#Use read.csv() to read the file 2016_10_11_plate_reader.csv in the github data directory, and store it in memory as an object. This is an output from an instrument that I have, that measures fluorescence in each well of a 96-well plate. (Hint: use the optional argument skip = 33. What effect does that have?)
my_data <- read.csv("F:/R_Course_GEOL590/data/2016_10_11_plate_reader.csv")
print(my_data)
read.csv("F:/R_Course_GEOL590/data/2016_10_11_plate_reader.csv", skip=33)
##Skip =33: This skips the first 33 lines of the .csv file. This creates nicely organized data and gets rid of the information about the plate.


#What kind of object did you create? What data type is each column of that object? 
str(my_data)
####
#'data.frame':	94 obs. of  3 variables:
#$ well     : Factor w/ 94 levels "A1","A10","A11",..: 1 5 6 7 8 9 10 11 2 3 ...
#$ voltage  : num  -12533 -11667 -3267 -3000 -933 ...
#$ r.squared: int  1 1 1 1 1 1 1 1 1 1 ...


#Read the same file using the read_csv function. How is the resulting object different?
read_csv("F:/R_Course_GEOL590/data/2016_10_11_plate_reader.csv")
my_data2 <- read_csv("F:/R_Course_GEOL590/data/2016_10_11_plate_reader.csv")
### This creates a tibble: 127 × 3
> str(my_data2)
#Classes 'tbl_df', 'tbl' and 'data.frame':	127 obs. of  3 variables
______________________________________________________________________________________________________
Subsetting

#Why does nrow(mtcars) give a different result than length(mtcars)? What does ncol(mtcars) return? What is each telling you, and why?
### The length() is the same as ncol() because it is equal to the length of the list making up the data frame. nrow() reflects the number of rows or observations.
nrow(mtcars)
#[1] 32
length(mtcars)
#[1] 11


#Create a vector that is the cyl column of mtcars in two different ways:
#using the $ operator
#using [] subsetting
######
b <- mtcars[["cyl"]] 
c <- mtcars$cyl

#Create a data frame that contains all the columns of mtcars, but only with cars that weigh less than 3.0 OR more than 4.0 (weight is in the wt column)
df <- subset(mtcars, wt < 3.0 | wt > 4.0)

#Create a data frame that contains all the rows of mtcars, but only the mpg and wt
df2 <- mtcars[c("mpg", "wt")] 

#Which cars in the database get gas mileage (mpg) equal to the median gas mileage for the set? (Use median and which).s
####I don't know how to apply which?????
median(mtcars$mpg)
###output = 19.2
mtcars[mtcars$mpg == 19.2, ]


#AR 3.1.7.1: Fix the following common subsetting errors (note that mtcars is a dataset that is built into base R; you don't have to do anything special to load it:
                                                        
mtcars[mtcars$cyl == 4, ] # Trying to create a data frame of cars with 4 cylinders only
                                                        
mtcars[-1:4, ]  #### NO IDEA WHAT THIS IS TRYING TO DO
                                                        
mtcars[mtcars$cyl <= 5, ]
                                                        
mtcars[mtcars$cyl == 4 | mtcars$cyl == 6, ] # The | is an 'or' operator - you want a data frame of cars with 4 OR 6 cylinder engines