# This requires the baccaratsim.R file to be run first.

# Histogram and density plots of various bets
# This code runs r simulations of n baccarat coups (i.e. hands) of all the different types of bets.
# It tallies up the ending profit/loss for each simulation and displays it in a histogram or density plot.

# ====================
# SETTINGS
# ====== EDIT BELOW =====
n <- 100
r <- 500
open_bal <- 0  # set to 0 to see profit-loss chart, otherwise it acts like a starting cash balance
# Payouts can be changed at the top of the baccaratsim.R file
# ====== EDIT ABOVE =====


# Note: This simulation takes a while to run, especially with large n and r!

# Turn off pairs
pair_player_bet <- 0
pair_house_bet <- 0
pair_either_bet <- 0

# First, betting on the house with commissions
house_commission <- TRUE
player_bet <- 0
house_bet <- 100
tie_bet <- 0
house_c_hist <- NULL
for (i in 1:r) {
  invisible(capture.output(house_c_sim <- simulation(n,open_bal,player_bet,house_bet,tie_bet,pair_player_bet,pair_house_bet,pair_either_bet,house_commission,tie_payout,pair_payout,e_pair_payout)[[1]]))
  house_c_hist <- c(house_c_hist,tail(house_c_sim,n=1))
}

# Second, betting on the house without commissions
house_commission <- FALSE
house_no_c_hist <- NULL
for (i in 1:r) {
  invisible(capture.output(house_no_c_sim <- simulation(n,open_bal,player_bet,house_bet,tie_bet,pair_player_bet,pair_house_bet,pair_either_bet,house_commission,tie_payout,pair_payout,e_pair_payout)[[1]]))
  house_no_c_hist <- c(house_no_c_hist,tail(house_no_c_sim,n=1))
}

# Third, betting on the player
house_commission <- TRUE
player_bet <- 100
house_bet <- 0
tie_bet <- 0
player_hist <- NULL
for (i in 1:r) {
  invisible(capture.output(player_sim <- simulation(n,open_bal,player_bet,house_bet,tie_bet,pair_player_bet,pair_house_bet,pair_either_bet,house_commission,tie_payout,pair_payout,e_pair_payout)[[1]]))
  player_hist <- c(player_hist,tail(player_sim,n=1))
}

# Fourth, betting on tie
player_bet <- 0
house_bet <- 0
tie_bet <- 100
tie_hist <- NULL
for (i in 1:r) {
  invisible(capture.output(tie_sim <- simulation(n,open_bal,player_bet,house_bet,tie_bet,pair_player_bet,pair_house_bet,pair_either_bet,house_commission,tie_payout,pair_payout,e_pair_payout)[[1]]))
  tie_hist <- c(tie_hist,tail(tie_sim,n=1))
}

# Fifth, betting on player pair 
player_bet <- 0
house_bet <- 0
tie_bet <- 0
pair_player_bet <- 100
pair_house_bet <- 0
pair_hist <- NULL
for (i in 1:r) {
  invisible(capture.output(pair_sim <- simulation(n,open_bal,player_bet,house_bet,tie_bet,pair_player_bet,pair_house_bet,pair_either_bet,house_commission,tie_payout,pair_payout,e_pair_payout)[[1]]))
  pair_hist <- c(pair_hist,tail(pair_sim,n=1))
}

# Sixth, betting on banker pair 
pair_player_bet <- 0
pair_house_bet <- 100
pair_house_hist <- NULL
for (i in 1:r) {
  invisible(capture.output(pair_house_sim <- simulation(n,open_bal,player_bet,house_bet,tie_bet,pair_player_bet,pair_house_bet,pair_either_bet,house_commission,tie_payout,pair_payout,e_pair_payout)[[1]]))
  pair_house_hist <- c(pair_house_hist,tail(pair_house_sim,n=1))
}

# Seventh, betting on either pair
pair_house_bet <- 0
pair_either_bet <- 100
either_hist <- NULL
for (i in 1:r) {
  invisible(capture.output(either_sim <- simulation(n,open_bal,player_bet,house_bet,tie_bet,pair_player_bet,pair_house_bet,pair_either_bet,house_commission,tie_payout,pair_payout,e_pair_payout)[[1]]))
  either_hist <- c(either_hist,tail(either_sim,n=1))
}

# If you want separate histograms (uncomment the code)
# par(mfrow=c(3,2))
# hist(house_c_hist, main="Banker (0.95-to-1)", xlab="Profit/Loss", col="red")
# hist(house_no_c_hist, main="Banker (1-to-1)", xlab="Profit/Loss", col="darkorange")
# hist(player_hist, main="Player (1-to-1)", xlab="Profit/Loss", col="blue")
# hist(tie_hist, main=paste0("Tie (",tie_payout,"-to-1)"), xlab="Profit/Loss", col="forestgreen")
# hist(pair_hist, main=paste0("Player pair (",pair_payout,"-to-1)"), xlab="Profit/Loss", col="purple")
# hist(pair_house_hist, main=paste0("Banker pair (",pair_payout,"-to-1)"), xlab="Profit/Loss", col="brown")
# hist(either_hist, main=paste0("Either pair (",e_pair_payout,"-to-1)"), xlab="Profit/Loss", col="hotpink")

# If you want one density plot (uncomment the code)
options("scipen" = 999)
par(mfrow=c(1,1))
histmin <- min(house_c_hist,house_no_c_hist,player_hist,tie_hist,pair_hist,either_hist)
histmax <- max(house_c_hist,house_no_c_hist,player_hist,tie_hist,pair_hist,either_hist)

png(filename = "sampleplots/density.png", width = 1280, height = 640)
plot(density(house_c_hist), xlim=c(histmin,histmax), main="Density plot of various punto banco baccarat bets", xlab="Profit/Loss", ylab="Density", lwd=2, col="red")
polygon(density(house_c_hist), col=rgb(1,0,0,0.2), border="red")
lines(density(house_no_c_hist), lwd=2, col="darkorange")
polygon(density(house_no_c_hist), col=rgb(1,140/255,0,0.2), border="darkorange")
lines(density(player_hist), lwd=2, col="blue")
polygon(density(player_hist), col=rgb(0,0,1,0.2), border="blue")
lines(density(tie_hist), lwd=2, col="forestgreen")
polygon(density(tie_hist), col=rgb(34/255,139/255,34/255,0.2), border="forestgreen")
lines(density(pair_hist), lwd=2, col="purple")
polygon(density(pair_hist), col=rgb(1,0,1,0.2), border="purple")
lines(density(pair_house_hist), lwd=2, col="brown")
polygon(density(pair_house_hist), col=rgb(165/255,42/255,42/255,0.2), border="brown")
lines(density(either_hist), lwd=2, col="hotpink")
polygon(density(either_hist), col=rgb(1,105/255,180/255,0.2), border="hotpink")
abline(v=0,lty=2)
legend("topleft", 
       bg="transparent",
       y.intersp=0.95,
       x.intersp=0.95,
       bty='n',
       legend=c("Banker (0.95-to-1)",
                "Banker (1-to-1)",
                "Player (1-to-1)",
                paste0("Tie (",tie_payout,"-to-1)"),
                paste0("Player pair (",pair_payout,"-to-1)"),
                paste0("Banker pair (",pair_payout,"-to-1)"),
                paste0("Either pair (",e_pair_payout,"-to-1)")), 
       lwd=c(2,2,2,2,2,2), 
       col=c("red","darkorange","blue","forestgreen", "purple", "brown", "hotpink"), title="Bet Types")
dev.off()