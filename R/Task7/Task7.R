#Upload large datasets
install.packages("nycflights13")
library(nycflights13)
install.packages( "babynames")
library(babynames)

#Install libraries tidyverse and dplyr
library(dplyr)
library(tidyverse)

############################################
###Part 1 of the task uses the below dataset
nycflights13::weather

##Part1A
#Determine whether there are any clear outliers in wind speed (wind_speed) that should be rejected.
#Filter those bad point(s) and proceed.
mean_sd_ws <- nycflights13::weather %>%
  select(wind_speed) %>%
  summarise(mean.wind_speed = mean(wind_speed, na.rm = TRUE), sd.wind_speed = 2*sd(wind_speed, na.rm = TRUE)) 
#There were only 3 outliers? Merged into a new dataset tidyweather
tidyweather <- nycflights13::weather %>%
  filter(wind_speed < (mean_sd_ws$mean.wind_speed + mean_sd_ws$sd.wind_speed) |wind_speed > (mean_sd_ws$mean.wind_speed - mean_sd_ws$sd.wind_speed))


##Part1B
#What direction has the highest median speed at each airport? Make a table and a plot of median wind speed by direction, for each airport.
#Table of median wind speed by direction for each airport
tidy_w <- tidyweather %>%
  group_by(wind_dir,origin) %>%
  select(wind_speed) %>%
  summarise(med.wind_speed = median(wind_speed, na.rm =TRUE)) %>%
  arrange(origin)
#EWR maximum median wind speed is from dirextions 290, 300, 320, and 330
#JFK max med wind speed is at directions 290, 300, 310, and 330
# LGA max med wind speed is at directions 260, 300, 310, 320, 270, 290

#plot of median wind speed by direction, for each airport
WindSpeed_dir <- tidy_w %>% ggplot(aes(x=wind_dir , y=med.wind_speed)) + facet_grid(origin~.) + geom_point() 
####################################

###Part2
##Part2A
#Using nycflights13::flights and nycflights13::airlines: Make a table with two columns: airline name (not carrier code) and median distance flown from JFK airport. The table should be arranged in order of decreasing mean flight distance. Hint: use a _join function to join flights and airlines.

#join together datasets airlines and flights into a new dataset called airline_flighths
airline_flights <- inner_join(nycflights13::flights, nycflights13::airlines)
#Make a table with two columns: airline name (not carrier code) and median distance flown from JFK airport. The table should be arranged in order of decreasing mean flight distance
medDistJFK <-airline_flights %>%
  group_by(name, origin) %>%
  select(distance)%>%
  filter(origin == "JFK") %>%
  summarise(med.distance = median(distance, na.rm =TRUE))%>%
  arrange(desc(med.distance))
#################################################

###Part3
#Make a wide-format data frame that displays the number of flights that leave Newark ("EWR") airport each month, from each airline
#tallies the flights by airline in each month and organizes into a data frame wide_data
wide_data <- airline_flights %>%
  group_by(origin) %>%
  filter(origin == "EWR") %>%
  select(month, name, flight) %>%
  group_by(month, name) %>%
  tally(flight) %>%
  spread(key=month, value= n)
##################################################

###Part4
#Using the babynames dataset:
#Identify the ten most common male and female names in 2014. 
pop_names <- babynames::babynames %>% 
  filter(year == "2014") %>%
  group_by(sex) %>%
  top_n(10, n)
#Make a plot of their frequency (prop) since 1880. (This may require two separate piped statements).
pop_names1 <-pop_names %>%
  select(name) 
freq_plot <- semi_join(babynames::babynames, pop_names1) %>%
  ggplot(aes(x=year , y=prop, colour=name)) + facet_grid(sex~.) + geom_point()
#come back and make plot nicer!  

#Make a single table of the 26th through 29th most common girls names in the year 1896, 1942, and 2016
baby_2 <- babynames::babynames %>% 
  filter(sex == "F") %>% 
  filter(year == "1896"| year == "1942"| year == "2016") %>%
  group_by(year) %>%
  top_n(30, n) %>% 
  slice(26:29)

max(babynames::babynames$year)
#The maximum year is 2014, so no data on 2016 is listed in baby_2
##############################

###Part5
#Write task that involves some of the functions on the Data Wrangling Cheat Sheet and execute it. You may either use your own data or data packages (e.g., the ones listed here).
#This wil be inlcuded in a different script