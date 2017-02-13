library(ggplot2)
metadataBone <- read.csv("C:/Users/Alexandra Emmons/Dropbox/BoneSurfaceProject/BoneSurface_metadata_revised.csv")
graph1 <- ggplot(metadataBone3, aes(Human.DNA, Bacterial.DNA, colour=Body.region)) + 
  geom_point() +
  facet_grid(Agency.ID ~.)
graph1 + ylab("Bacterial DNA yield (copy#/μl)") + xlab("Human DNA yield (ng/g)")+ 
  scale_colour_discrete(name = "Bone Region") 

metadataBone2 <- read.csv("C:/Users/Alexandra Emmons/Dropbox/BoneSurfaceProject/BoneSurface_metadata_revised1.csv")
graph2 <- ggplot(metadataBone3, aes(X..Cortical, Bacterial.DNA, colour=Body.region)) + 
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, inherit.aes = FALSE, aes(X..Cortical, Bacterial.DNA))

graph2 + ylab("Bacterial DNA yield (copy#/μl)") + xlab("Percent Cortical Bone (%)")+ 
  scale_colour_discrete(name = "Bone Region")

fit1 <- lm(Bacterial.DNA ~ X..Cortical, data = metadataBone3, na.action = na.exclude)
summary(fit1)
fit2 <- lm(Bacterial.DNA ~ Human.DNA, data = metadataBone3)
summary(fit2)


metadataBone3$trans_Bacterial.DNA <- log(metadataBone3$Bacterial.DNA)
graph4 <- ggplot(metadataBone3, aes(X..Cortical, trans_Bacterial.DNA, colour=Body.region)) + 
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, inherit.aes = FALSE, aes(X..Cortical, trans_Bacterial.DNA))

graph4 + ylab("Bacterial DNA yield log(copy#/μl)") + xlab("Percent Cortical Bone (%)")+ 
  scale_colour_discrete(name = "Bone Region")

fit3 <- lm(trans_Bacterial.DNA ~ X..Cortical, data = metadataBone3, na.action = na.exclude)
summary(fit3)