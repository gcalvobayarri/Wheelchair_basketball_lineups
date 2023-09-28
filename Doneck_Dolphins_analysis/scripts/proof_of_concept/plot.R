load('./results/proof_of_concepts/predictives.RData')
load('./data/Trier_data_clean.RData')

PIR17 <- apply(predictive_match_17_PIR, 1, mean)
EFF17 <- apply(predictive_match_17_EFF, 1, mean)
WIN17 <- apply(predictive_match_17_Win, 1, mean)
Trier17 <- subset(Trier_data, id_game == 17)

PIR18 <- apply(predictive_match_18_PIR, 1, mean)
EFF18 <- apply(predictive_match_18_EFF, 1, mean)
WIN18 <- apply(predictive_match_18_Win, 1, mean)
Trier18 <- subset(Trier_data, id_game == 18)

# Plot-----

Predictive_17 <- data.frame(
  Player=rep(c("A. Breuer", "C. Rossi", "D. Green", "D. Passivan", "L. Jung",
               "N. Passivan", "P. Dorner", "S. Erni", "W. Vlaanderen"), 3),
  Values=c(EFF17,
                PIR17,
                WIN17, Trier17$EFF_per_min[1:7], NA, Trier17$EFF_per_min[8],
               Trier17$PIR_per_min[1:7], NA, Trier17$PIR_per_min[8],
               Trier17$Winscore_min[1:7], NA, Trier17$Winscore_min[8]),
  Metric=c(rep("EFF",9), rep("PIR",9), rep("Win Score",9), rep("EFF",9), 
           rep("PIR",9), rep("Win Score",9)),
  Shape=as.factor(c(rep("Prediction",27), rep("Observation",27))))

library(ggplot2)
library(viridis)
ggplot(Predictive_17, aes(Player, Values, colour = Metric, shape=(Shape))) +
  geom_point(size = 9, alpha = 0.7) +
  ylim(-0.5,1.6) +
  theme_minimal(base_size = 20, base_line_size = 15/20)+
  # theme(legend.position = "none")+
  labs(x=element_blank())+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.3, hjust=1))+
  scale_shape_manual(values = c("Prediction" = 19, "Observation" = 18), 
                     labels=c('Prediction', 'Observation')) +
  scale_color_viridis(discrete = TRUE, option = "D")+
  guides(color=guide_legend(title= 'Metric', 
                            order = 1,
                            override.aes = list(shape = 15)),
         shape = guide_legend(title= '', 
                              order = 2,
                              override.aes = list(color = "black")))


#18
Predictive_18 <- data.frame(
  Player=rep(c("A. Breuer", "C. Rossi", "D. Green", "D. Passivan", "L. Jung",
               "N. Passivan", "P. Dorner", "S. Erni", "W. Vlaanderen"), 3),
  Values=c(EFF18,
           PIR18,
           WIN18, Trier18$EFF_per_min[1:7], NA, Trier18$EFF_per_min[8],
           Trier18$PIR_per_min[1:7], NA, Trier18$PIR_per_min[8],
           Trier18$Winscore_min[1:7], NA, Trier18$Winscore_min[8]),
  Metric=c(rep("EFF",9), rep("PIR",9), rep("Win Score",9), rep("EFF",9), 
           rep("PIR",9), rep("Win Score",9)),
  Shape=as.factor(c(rep("Prediction",27), rep("Observation",27))))


ggplot(Predictive_18, aes(Player, Values, colour = Metric, shape=(Shape))) +
  geom_point(size = 9, alpha = 0.7) +
  ylim(-0.5,1.6) +
  theme_minimal(base_size = 20, base_line_size = 15/20)+
  # theme(legend.position = "none")+
  labs(x=element_blank())+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.3, hjust=1))+
  scale_shape_manual(values = c("Prediction" = 19, "Observation" = 18), 
                     labels=c('Prediction', 'Observation')) +
  scale_color_viridis(discrete = TRUE, option = "D")+
  guides(color=guide_legend(title= 'Metric', 
                            order = 1,
                            override.aes = list(shape = 15)),
         shape = guide_legend(title= '', 
                              order = 2,
                              override.aes = list(color = "black")))
