# This requires the baccaratsim.R file to be run first.

# Histograms of various bets
# This simulation takes a while to run, especially with large n and r!

n <- 100
r <- 1000
open_bal <- 0
tie_payout <- 8

# First, betting on the house with commissions
house_commission <- TRUE
player_bet <- 0
house_bet <- 100
tie_bet <- 0
house_c_hist <- NULL
for (i in 1:r) {
  invisible(capture.output(house_c_sim <- simulation(n,open_bal,player_bet,house_bet,tie_bet,house_commission,tie_payout)))
  house_c_hist <- c(house_c_hist,tail(house_c_sim,n=1))
}

# Second, betting on the house without commissions
house_commission <- FALSE
house_no_c_hist <- NULL
for (i in 1:r) {
  invisible(capture.output(house_no_c_sim <- simulation(n,open_bal,player_bet,house_bet,tie_bet,house_commission,tie_payout)))
  house_no_c_hist <- c(house_no_c_hist,tail(house_no_c_sim,n=1))
}

# Third, betting on the player
house_commission <- TRUE
player_bet <- 100
house_bet <- 0
tie_bet <- 0
player_hist <- NULL
for (i in 1:r) {
  invisible(capture.output(player_sim <- simulation(n,open_bal,player_bet,house_bet,tie_bet,house_commission,tie_payout)))
  player_hist <- c(player_hist,tail(player_sim,n=1))
}

# Fourth, betting on tie
player_bet <- 0
house_bet <- 0
tie_bet <- 100
tie_hist <- NULL
for (i in 1:r) {
  invisible(capture.output(tie_sim <- simulation(n,open_bal,player_bet,house_bet,tie_bet,house_commission,tie_payout)))
  tie_hist <- c(tie_hist,tail(tie_sim,n=1))
}

# # If you want separate histograms
# par(mfrow=c(2,2))
# hist(house_c_hist, main="House (0.95-to-1)", xlab="Profit/Loss", col="red")
# hist(house_no_c_hist, main="House (1-to-1)", xlab="Profit/Loss", col="darkorange")
# hist(player_hist, main="Player", xlab="Profit/Loss", col="blue")
# hist(tie_hist, main="Tie", xlab="Profit/Loss", col="forestgreen")

# If you want one density plot
par(mfrow=c(1,1))
histmin <- min(house_c_hist,house_no_c_hist,player_hist,tie_hist)
histmax <- max(house_c_hist,house_no_c_hist,player_hist,tie_hist)
plot(density(house_c_hist), xlim=c(histmin,histmax), main="Density plot of various bets", xlab="Profit/Loss", ylab="Density", lwd=2, col="red")
polygon(density(house_c_hist), col=rgb(1,0,0,0.2), border="red")
lines(density(house_no_c_hist), lwd=2, col="darkorange")
polygon(density(house_no_c_hist), col=rgb(1,140/255,0,0.2), border="darkorange")
lines(density(player_hist), lwd=2, col="blue")
polygon(density(player_hist), col=rgb(0,0,1,0.2), border="blue")
lines(density(tie_hist), lwd=2, col="forestgreen")
polygon(density(tie_hist), col=rgb(34/255,139/255,34/255,0.2), border="forestgreen")
abline(v=0,lty=2)
legend("topleft", bg="transparent",legend=c("House (0.95-to-1)","House (1-to-1)","Player",paste0("Tie (",tie_payout,"-to-1)")), lwd=c(2,2,2,2), col=c("red","darkorange","blue","forestgreen"), title="Bet Types")