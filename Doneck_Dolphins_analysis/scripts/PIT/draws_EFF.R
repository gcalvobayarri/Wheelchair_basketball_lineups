#draws
# 1. Saving posterior iterations-------------------------
library(rjags)
library(MCMCvis)

load('./results/res_mixed_model_Trier_EFF.RData') #rsamps

n <- 9
matches <- 18
I <- 1000
C <- 3

beta0 <- as.vector(unlist(MCMCchains(rsamps,
                                     params = "beta0", ISB = F)))
beta1 <- as.vector(unlist(MCMCchains(rsamps,
                                     params = "beta1", ISB = F)))
betaC <- as.vector(unlist(MCMCchains(rsamps,
                                     params = "betaC", ISB = F)))
betaH <- as.vector(unlist(MCMCchains(rsamps,
                                     params = "betaH", ISB = F)))
betaW <- as.vector(unlist(MCMCchains(rsamps,
                                     params = "betaW", ISB = F)))
sigma <- as.vector(unlist(MCMCchains(rsamps,
                                     params = "sigma", ISB = F)))
sigma0 <- as.vector(unlist(MCMCchains(rsamps,
                                      params = "sigma0", ISB = F)))
sigma0m <- as.vector(unlist(MCMCchains(rsamps,
                                       params = "sigma0m", ISB = F)))
sigma1 <- as.vector(unlist(MCMCchains(rsamps,
                                      params = "sigma1", ISB = F)))
b0 <- matrix(data = NA, nrow = n, ncol = C * I)
b1 <- matrix(data = NA, nrow = n, ncol = C * I)
b0m <- matrix(data = NA, nrow = matches, ncol = C * I)


for(nn in 1 : n){
  b0[nn, ] <- as.vector(unlist(MCMCchains(rsamps,
                                          params = paste('b0[', nn, ']', sep = ''), 
                                          ISB = F)))
  b1[nn, ] <- as.vector(unlist(MCMCchains(rsamps,
                                          params = paste('b1[', nn, ']', sep = ''), 
                                          ISB = F)))
}

for(nn in 1 : matches){
  b0m[nn, ] <- as.vector(unlist(MCMCchains(rsamps,
                                           params = paste('b0m[', nn, ']', sep = ''), 
                                           ISB = F)))
}

draws_posterior <- cbind(beta0, beta1, betaC, betaH, betaW, sigma, 
                         sigma0, sigma0m, sigma1, t(b0), t(b1), t(b0m))

#draws_posterior
# beta0 column 1
# beta1 column 2
# betaC column 3
# betaH column 4
# betaW column 5

# sigma column 6
# sigma0 column 7
# sigma0m column 8
# sigma1 column 9

# b0 columns 10 - 18
# b1 columns 19 - 27
# b0m columns 28-45

rm(rsamps, beta0, beta1, betaC, betaH, betaW, sigma, sigma0, sigma0m, sigma1, 
   b0, b1, b0m, C, I, matches, n, nn)
