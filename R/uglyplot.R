food <- read.csv("C:/Users/Alexandra Emmons/Dropbox/R_Course_GEOL590/Book1.csv")
library(ggplot2)
food_g <- ggplot(food, aes(Steak, Salad, colour = Political.view, shape = Region)) +
  geom_point()
  
  
  



food_g + ggtitle("Food Preferences and Politics") + 
  theme(panel.background = element_rect(fill = "lightskyblue2", color = "red3", size = 2)) + 
  theme(panel.grid = element_blank()) +
  scale_color_manual(breaks = c("DEM", "IND", "REP"), values=c("blue", "springgreen4", "red"))