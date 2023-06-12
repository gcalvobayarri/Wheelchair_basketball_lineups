load('./results/lineups_EFF.RData')
load('./results/lineups_PIR.RData')
load('./results/lineups_winscore.RData')

# Probability of being in the lineup
posterior <- posterior_PIR

Lineups <- matrix(data = NA, nrow = 3000, ncol = 9)
for(i in 1 : 3000){ #all the lineups
  Lineups[i, ] <- as.numeric(substring(posterior[i], seq(1,17, by = 2), 
                                       seq(1,17, by = 2)))
}

sum(Lineups[,1]) /3000 # Annabel Breuer
sum(Lineups[,2]) /3000 # Correy Rossi
sum(Lineups[,3]) /3000 # Dejon Green
sum(Lineups[,4]) /3000 # Dirk Passivan
sum(Lineups[,5]) /3000 # Lucas Jung
sum(Lineups[,6]) /3000 # Natalie Passivan
sum(Lineups[,7]) /3000 # Patrick Dorner
sum(Lineups[,8]) /3000 # Svenja Erni
sum(Lineups[,9]) /3000 # Walter Vlandeeren


# Probability of playing together (intersection)

# probabilities
players <- c(1, 2, 4, 9) # indices of the players
count <- 0
for(i in 1 : 3000){
  logic <- as.numeric(Lineups[i, players] == rep(1, length(players)))
  if(sum(logic) == length(players)){count <- count + 1}
}
prob <- count / 3000


players <- c(1, 2, 4, 9, 8) # indices of the players
count <- 0
for(i in 1 : 3000){
  logic <- as.numeric(Lineups[i, players] == rep(1, length(players)))
  if(sum(logic) == length(players)){count <- count + 1}
}
prob2 <- count / 3000

prob2 / prob # conditional probabilities

# Plot-----

P_inclusion <- data.frame(
  Player=rep(c("A. Breuer", "C. Rossi", "D. Green", "D. Passivan", "L. Jung",
           "N. Passivan", "P. Dorner", "S. Erni", "W. Vlaanderen"), 3),
  Probability=c(0.79, 0.61, 0.32, 0.98, 0.28, 0.32, 0.63, 0.45, 0.61,
                0.78, 0.61, 0.36, 0.98, 0.26, 0.32, 0.59, 0.48, 0.62,
                0.79, 0.61, 0.30, 0.96, 0.32, 0.32, 0.46, 0.51, 0.72),
  Metric=c(rep("EFF",9), rep("PIR",9), rep("Win Score",9)))


library(ggplot2)
ggplot(P_inclusion, aes(Player, Probability, colour = Metric, shape=Metric)) +
  geom_point(size = 5, alpha = 0.8) +
  theme_test(base_size = 20, base_line_size = 15/20)+   
  guides(color=guide_legend(title= expression(paste("P(", italic(I)[i],')')), 
                             override.aes=list(shape = c(19, 17, 15)), color = F)) +
  # theme(legend.position = "none")+
  labs(x=element_blank())+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.3, hjust=1)) +
  guides(shape="none")
  #+ 
  # scale_color_discrete(name = expression(paste("P(", italic(L)[i],')'))) 
  
