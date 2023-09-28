# Information extracted from posterior_probabilities_players.R

p_player <- data.frame(Player = rep(c("D. Green", "L. Jung", "N. Passivan", 
                                      "P. Dorner", "S. Erni"), 3),
                       Probability = c(0.17, 0.02, 0.22, 0.47, 0.11,
                                       0.2, 0.01, 0.23, 0.42, 0.13,
                                       0.17, 0.04, 0.27, 0.32, 0.19),
                       Metric=c(rep("EFF",5), rep("PIR",5), rep("Win Score",5)))

library(ggplot2)
library(viridis)

ggplot(p_player, aes(x=Player, y=Probability, fill = Metric)) + 
  geom_bar(stat = "identity", position = position_dodge())  +
  scale_fill_viridis(discrete = TRUE, option = "D")+
  theme_test(base_size = 20, base_line_size = 15/20) +
  labs(x=element_blank())
