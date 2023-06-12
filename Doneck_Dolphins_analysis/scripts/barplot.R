load('./results/lineups_PIR.RData')
load('./results/lineups_EFF.RData')
load('./results/lineups_Winscore.RData')

# 1. PIR line-ups---------
sort(summary_PIR)
sum(summary_PIR)

barplot(c(418/3000, 354/3000, 232/3000, 202/3000, 182/3000, 170/3000, 134/3000), 
        names=c(expression(L[1]), expression(L[2]), expression(L[3]), 
                expression(L[4]), expression(L[5]), expression(L[6]),
                expression(L[7])),
        col = rgb(0.8,0,0, .6), ylim = c(0, 0.2), cex.names = 1.5, 
        cex.axis = 1.5, ylab = "Relative frequency",
        cex.lab=1.5, cex.main=1.5)



# 2. EFF line-ups---------
sort(summary_EFF)
sum(summary_EFF)

barplot(c(468/3000, 364/3000, 221/3000, 164/3000, 149/3000, 137/3000, 113/3000), 
        names=c(expression(L[1]), expression(L[2]), expression(L[3]), 
                expression(L[4]), expression(L[5]), expression(L[6]),
                expression(L[7])),
        col = rgb(0.8,0,0, .6), ylim = c(0, 0.2), cex.names = 1.5, 
        cex.axis = 1.5, ylab = "Relative frequency",
        cex.lab=1.5, cex.main=1.5)

# 3. Winscore line-ups---------
sort(summary_winscore)
sum(summary_winscore)

barplot(c(343/3000, 328/3000, 292/3000, 179/3000, 197/3000, 230/3000, 202/3000), 
        names=c(expression(L[1]), expression(L[2]), expression(L[3]), 
                expression(L[4]), expression(L[5]), expression(L[6]),
                expression(L[7])),
        col = rgb(0.8,0,0, .6), ylim = c(0, 0.2), cex.names = 1.5, 
        cex.axis = 1.5, ylab = "Relative frequency",
        cex.lab=1.5, cex.main=1.5)

