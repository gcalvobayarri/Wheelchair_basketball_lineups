SOFTWARE NEEDED: R and JAGS. All codes are in R language.

This folder contains the statistical analysis carried out in the real case application of the paper "Selecting the best compositions of a wheelchair basketball team: a data-driven approach". The material available here is as follows.

1. Folder "data": it includes four elements, i. e., data_players.xlsx, data_trier.xlsx, line_ups.RData and Trier_data_clean.RData. 
data_players.xlsx: Functional classification and sex of the players (excel format).
data_trier.xlsx: Performance data of the players (excel format). 
line_ups.RData: Number of female players and total functional points for each possible team line-up (R format).
Trier_data_clean.RData: Performance data of the players (R format).

2. Folder "figures": all of the figures presented in the paper in PDF format.

3. Folder "functions": it includes the function used for predicting (model_prediction_type.R) and a logarithmic summation function (suma_logaritmica_de_elementos.R).

4. Folder "models": the Bayesian longitudinal  model used in the case study in JAGS format.

5. Folder "results": it contains samples from JAGS of the posterior distribution of the parameters (res_mixed_model_Trier_EFF.RData, res_mixed_model_Trier_PIR.RData and res_mixed_model_Trier_Winscore.RData), the obtained PIT values for each model (PIT_EFF.RData, PIT_PIR.RData and PIT_WIN.RData) and the results of the linear integer problem (lineups_EFF.RData, lineups_PIR.RData and lineups_winscore.RData).

6. Folder "scripts": it contains seven general scripts for the analysis, i. e., maximization_posterior_complete.R, barplot.R, barplot_5th_player.R, mixed_model_Trier.R, posterior_probabilities_players.R, Trier_data_clean.R and trier_data_plots.R. In addition, the PIT folder contains all the code needed to compute the PIT vales.
maximization_posterior_complete.R: (In optimisation folder) code for solving the optimisation problem. 
barplot.R: code for ploting the optimisation results, the most optimal line-ups (Figure 2). 
barplot_5th_player.R: code for Figure 4. 
mixed_model_Trier.R: code for computing the JAGS model and seeing the posterior results.
posterior_probabilities_players.R: code for Figure 3.
Trier_data_clean.R: code for adapting the data to our analysis.
trier_data_plots.R: code for Figure 1.
