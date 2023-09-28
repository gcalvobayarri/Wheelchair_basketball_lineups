model_prediction_type_proof <- function(player = players, type="PIR", 
                                        match = tt){
  #player is numeric
  # 1. Loading posterior iterations-------------------------
  library(rjags)
  library(MCMCvis)
  
  #type in ("PIR", "EFF", "Winscore")
  #input----------
  
  load('./data/Trier_data_clean.RData')
  Trier_data <- subset(Trier_data, id_game < match)
  
  # RUNNING THE MODEL
  # PIR
  if(type=='PIR'){
  useful <- which(!is.na(Trier_data$PIR_per_min)) 
  data_model <- list(Y = Trier_data$PIR_per_min,  
                     N = max(unique(Trier_data$id_player)), useful = useful,
                     id_player = Trier_data$id_player, 
                     id_game = Trier_data$id_game,
                     W = Trier_data$sex, Class = Trier_data$class, 
                     home = Trier_data$home)
  inits <- function() {
    list( beta0 = runif(1, 4, 8), beta1 = runif(1, -5, 5),
          sigma = runif(1, 0, 5), sigma0 = runif(1, 0, 5), 
          sigma1 = runif(1, 0, 0.5))
  }
  parameters <- c( "beta0", "beta1", "betaW", "betaC", "betaH", "b0", "b0m",  "b1", 
                   "sigma", "sigma0",  "sigma0m", "sigma1")
  
  
  results <- jags.model("./models/mixed_model_Trier.txt", data_model, inits, n.chains = 3,
                        n.adapt = 0)
  
  update(results, n.iter = 300000)
  rsamps <- coda.samples(results, parameters, n.iter = 100000,  thin = 100)}
 
  # EFF
  if(type=='EFF'){
    useful <- which(!is.na(Trier_data$EFF_per_min)) 
    data_model <- list(Y = Trier_data$EFF_per_min,  
                       N = max(unique(Trier_data$id_player)), useful = useful,
                       id_player = Trier_data$id_player, 
                       id_game = Trier_data$id_game,
                       W = Trier_data$sex, Class = Trier_data$class, 
                       home = Trier_data$home)
    inits <- function() {
      list( beta0 = runif(1, 4, 8), beta1 = runif(1, -5, 5),
            sigma = runif(1, 0, 5), sigma0 = runif(1, 0, 5), 
            sigma1 = runif(1, 0, 0.5))
    }
    parameters <- c( "beta0", "beta1", "betaW", "betaC", "betaH", "b0", "b0m",  "b1", 
                     "sigma", "sigma0",  "sigma0m", "sigma1")
    
    
    results <- jags.model("./models/mixed_model_Trier.txt", data_model, inits, n.chains = 3,
                          n.adapt = 0)
    
    update(results, n.iter = 300000)
    rsamps <- coda.samples(results, parameters, n.iter = 100000,  thin = 100)}
  
  # Winscore
  if(type=='Winscore'){
    useful <- which(!is.na(Trier_data$Winscore_min)) 
    data_model <- list(Y = Trier_data$Winscore_min,  
                       N = max(unique(Trier_data$id_player)), useful = useful,
                       id_player = Trier_data$id_player, 
                       id_game = Trier_data$id_game,
                       W = Trier_data$sex, Class = Trier_data$class, 
                       home = Trier_data$home)
    inits <- function() {
      list( beta0 = runif(1, 4, 8), beta1 = runif(1, -5, 5),
            sigma = runif(1, 0, 5), sigma0 = runif(1, 0, 5), 
            sigma1 = runif(1, 0, 0.5))
    }
    parameters <- c( "beta0", "beta1", "betaW", "betaC", "betaH", "b0", "b0m",  "b1", 
                     "sigma", "sigma0",  "sigma0m", "sigma1")
    
    
    results <- jags.model("./models/mixed_model_Trier.txt", data_model, inits, n.chains = 3,
                          n.adapt = 0)
    
    update(results, n.iter = 300000)
    rsamps <- coda.samples(results, parameters, n.iter = 100000,  thin = 100)}
  
  
   
  sex <- c()
  class <- c()
  
  T <- match
  C <- 3
  I <- 1000
  
  b0 <- matrix(data = NA, nrow = length(player), ncol = I * C)
  b1 <- matrix(data = NA, nrow = length(player), ncol = I * C)
  
  predictive <- matrix(data = NA, nrow = length(player), ncol = I * C)
  
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
  
  sigma0m <- as.vector(unlist(MCMCchains(rsamps,
                                         params = 'sigma0m', ISB = F)))
  
  sigma <- as.vector(unlist(MCMCchains(rsamps,
                                       params = 'sigma', ISB = F)))
  
  for(p in 1 : length(player)){
    
    sex[p] <- unique(Trier_data$sex[Trier_data$id_player == player[p]])
    class[p] <- unique(Trier_data$class[Trier_data$id_player == player[p]])
    
    
    
    b0[p,] <- as.vector(unlist(MCMCchains(rsamps,
                                          params = paste('b0[',p,']', sep = ''), ISB = F)))
    b1[p,] <- as.vector(unlist(MCMCchains(rsamps,
                                          params = paste('b1[',p,']', sep = ''), ISB = F)))
    
    
    
    
    for(i in 1 : (I * C)){
      m <- rnorm(1, 0, sd = sigma0m[i])
      predictive[p, i] <- rnorm(1, beta0[i] + b0[p, i] + m + betaW[i] * sex[p]
                                + betaC[i] * class[p] + betaH[i] + (beta1[i] + b1[p, i]) * (T), 
                                sd = sigma[i])
    }
    
  }
  
  return(predictive)
}

set.seed(83692)
predictive_match_17_PIR <- model_prediction_type_proof(player = 1:9, match = 17)
predictive_match_17_EFF <- model_prediction_type_proof(player = 1:9, match = 17, 
                                                       type = 'EFF')
predictive_match_17_Win <- model_prediction_type_proof(player = 1:9, match = 17, 
                                                       type = 'Winscore')

predictive_match_18_PIR <- model_prediction_type_proof(player = 1:9, match = 18)
predictive_match_18_EFF <- model_prediction_type_proof(player = 1:9, match = 18, 
                                                       type = 'EFF')
predictive_match_18_Win <- model_prediction_type_proof(player = 1:9, match = 18, 
                                                       type = 'Winscore')


save(predictive_match_17_EFF, predictive_match_17_PIR, predictive_match_17_Win,
     predictive_match_18_PIR, predictive_match_18_EFF, predictive_match_18_Win,
     file = './results/proof_of_concepts/predictives.RData')
