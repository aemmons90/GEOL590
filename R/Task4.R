library(ggplot2)
#Practice: working through Resources
graph1 <- ggplot(mpg, aes(cty, hwy)) + 
         geom_point()
print(graph1)

#Working with the diamonds dataset
#Determining the number of rows in the diamond dataset
nrow(diamonds)
#There are 53,940 rows. 
?set.seed()
set.seed(1410)
#Set.seed will provide a random sample set of the type 1410 from teh diamond dataset
dsmall <- diamonds[sample(nrow(diamonds), 100), ]
#This took a random subset of diamonds equal to 100 rows and stored it as the object dsmall 
g_dsmall <- ggplot(dsmall, aes(x, y)) +
  geom_point() +
  facet_grid(~cut)
#A scatterplot of y vs x, colored by z values and faceted by cut 
g1_dsmall <- ggplot(dsmall, aes(carat, price, colour=cut)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)
#A scatterplot of price vs carat, colored by cut and smoothed (using the "lm" method, without standard error bars)
g2_dsmall <- ggplot(dsmall, aes(carat, colour=clarity)) +
  facet_grid(~clarity) +
  geom_density()
#A density plot of carat, faceted and colored by clarity 
g3_dsmall <- ggplot(dsmall, aes(cut, price)) +
  geom_boxplot()
#A boxplot of price as a function of cut 
g4_dsmall <- ggplot(dsmall, aes(x,y))+
  geom_point(colour="red") +
  geom_smooth(colour = "blue", linetype = 2, se = FALSE) 
g4_dsmall + xlab("x, in mm") + ylab("y, in mm")
#A scatterplot of y versus x. The points should be red (colour = "red"), the color of the smoothing line should be blue (colour = "blue"), and the line should be dashed with fat dashes (linetype=2). 


