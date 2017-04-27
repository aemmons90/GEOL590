library(tidyverse)
my_data <- read.csv("F:/R_Course_GEOL590/data/2016_10_11_plate_reader.csv")
print(my_data)
read.csv("F:/R_Course_GEOL590/data/2016_10_11_plate_reader.csv", skip=33)
str(my_data)
library(readr)
read_csv("F:/R_Course_GEOL590/data/2016_10_11_plate_reader.csv")
my_data2 <- read_csv("F:/R_Course_GEOL590/data/2016_10_11_plate_reader.csv")
b <- mtcars[["cyl"]]
c <- mtcars$cyl
