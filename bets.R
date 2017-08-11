# This requires the baccaratsim.R file to be run first.


# Plays a single round of baccarat
# Bets
# player_bet <- 10
# house_bet <- 0
# tie_bet <- 0
# round(player_bet,house_bet,tie_bet,house_commission,tie_payout)


# Simulates n rounds of baccarat
# player_bet <- 0
# house_bet <- 10
# tie_bet <- 0
# n <- 100
# open_bal <- 500
# simulation(n,open_bal,player_bet,house_bet,tie_bet,house_commission,tie_payout)


# Let's see how the various types of bets work out
n <- 2000
open_bal <- 0
tie_payout <- 8


# If you run the simulations and graph enough times, you will notice that usually, the lowest house edge is on house, then player, then tie.
# This is especially true as you increase n (but the simulation takes longer!)
# You can also try changing the tie_payout to see what payout you need to not fare as worse as player/house bets. 10 seems to do it.
# 9 still gives the house an edge.


# First, betting on the house with commissions
house_commission <- TRUE
player_bet <- 0
house_bet <- 100
tie_bet <- 0
invisible(capture.output(house_c_sim <- simulation(n,open_bal,player_bet,house_bet,tie_bet,house_commission,tie_payout)))

# Second, betting on the house without commissions
house_commission <- FALSE
invisible(capture.output(house_no_c_sim <- simulation(n,open_bal,player_bet,house_bet,tie_bet,house_commission,tie_payout)))

# Third, betting on the player
house_commission <- TRUE
player_bet <- 100
house_bet <- 0
tie_bet <- 0
invisible(capture.output(player_sim <- simulation(n,open_bal,player_bet,house_bet,tie_bet,house_commission,tie_payout)))

# Fourth, betting on tie
player_bet <- 0
house_bet <- 0
tie_bet <- 100
invisible(capture.output(tie_sim <- simulation(n,open_bal,player_bet,house_bet,tie_bet,house_commission,tie_payout)))

ymin <- min(house_c_sim,house_no_c_sim,player_sim,tie_sim)
ymax <- max(house_c_sim,house_no_c_sim,player_sim,tie_sim)
plot(house_c_sim,type="l",lwd=2,col="red",ylab="Profit / Loss",xlab="Round",ylim=c(ymin,ymax), main="Simulation of various bets")
lines(house_no_c_sim,lwd=2,col="darkorange")
lines(player_sim,lwd=2,col="blue")
lines(tie_sim,lwd=2,col="forestgreen")
legend("bottomleft", bg="transparent",legend=c("House (0.95-to-1)","House (1-to-1)","Player",paste0("Tie (",tie_payout,"-to-1)")), lwd=c(2,2,2,2), col=c("red","darkorange","blue","forestgreen"), title="Bet Types")