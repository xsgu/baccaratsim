# This requires the baccaratsim.R file to be run first.


# Plays a single round of baccarat
# Change the bets to your desired bet amounts.
# player_bet <- 0
# house_bet <- 0
# tie_bet <- 0
# pair_player_bet <- 0
# pair_house_bet <- 0
# pair_either_bet <- 10
# round(player_bet,house_bet,tie_bet,pair_player_bet,pair_house_bet,pair_either_bet,house_commission,tie_payout,pair_payout,e_pair_payout)


# Simulates n rounds of baccarat
# Change the bets to your desired bet amounts.
# player_bet <- 0
# house_bet <- 0
# tie_bet <- 0
# pair_player_bet <- 0
# pair_house_bet <- 0
# pair_either_bet <- 10
# n <- 50
# open_bal <- 5000
# simulation(n,open_bal,player_bet,house_bet,tie_bet,pair_player_bet,pair_house_bet,pair_either_bet,house_commission,tie_payout,pair_payout,e_pair_payout)


# Let's see how the various types of bets work out
# SETTINGS
# ====== EDIT BELOW =====
n <- 1000 
open_bal <- 0  # set to 0 to see profit-loss chart, otherwise it acts like a starting cash balance
tie_payout <- 8
pair_payout <- 11
e_pair_payout <- 5
# ====== EDIT ABOVE =====
# Note: This simulation takes a while to run, especially with large n!


# If you run the simulations and graph enough times, you will notice that usually, the lowest house edge is on banker, then player, then pair, then tie.
# With no-commission baccarat, the player has an edge!

# Turn off pairs
pair_player_bet <- 0
pair_house_bet <- 0
pair_either_bet <- 0

# First, betting on the house with commissions
house_commission <- TRUE
player_bet <- 0
house_bet <- 100
tie_bet <- 0
invisible(capture.output(house_c_sim <- simulation(n,open_bal,player_bet,house_bet,tie_bet,pair_player_bet,pair_house_bet,pair_either_bet,house_commission,tie_payout,pair_payout,e_pair_payout)))

# Second, betting on the house without commissions
house_commission <- FALSE
invisible(capture.output(house_no_c_sim <- simulation(n,open_bal,player_bet,house_bet,tie_bet,pair_player_bet,pair_house_bet,pair_either_bet,house_commission,tie_payout,pair_payout,e_pair_payout)))

# Third, betting on the player
house_commission <- TRUE
player_bet <- 100
house_bet <- 0
tie_bet <- 0
invisible(capture.output(player_sim <- simulation(n,open_bal,player_bet,house_bet,tie_bet,pair_player_bet,pair_house_bet,pair_either_bet,house_commission,tie_payout,pair_payout,e_pair_payout)))

# Fourth, betting on tie
player_bet <- 0
house_bet <- 0
tie_bet <- 100
invisible(capture.output(tie_sim <- simulation(n,open_bal,player_bet,house_bet,tie_bet,pair_player_bet,pair_house_bet,pair_either_bet,house_commission,tie_payout,pair_payout,e_pair_payout)))

# Fifth, betting on player pair
player_bet <- 0
house_bet <- 0
tie_bet <- 0
pair_player_bet <- 100
invisible(capture.output(pair_sim <- simulation(n,open_bal,player_bet,house_bet,tie_bet,pair_player_bet,pair_house_bet,pair_either_bet,house_commission,tie_payout,pair_payout,e_pair_payout)))

# Sixth, better on either pair
pair_player_bet <- 0
pair_either_bet <- 100
invisible(capture.output(p_e_sim <- simulation(n,open_bal,player_bet,house_bet,tie_bet,pair_player_bet,pair_house_bet,pair_either_bet,house_commission,tie_payout,pair_payout,e_pair_payout)))

# Plot
ymin <- min(house_c_sim,house_no_c_sim,player_sim,tie_sim,pair_sim,p_e_sim)
ymax <- max(house_c_sim,house_no_c_sim,player_sim,tie_sim,pair_sim,p_e_sim)
plot(house_c_sim,type="l",lwd=2,col="red",ylab="Profit / Loss",xlab="Round",ylim=c(ymin,ymax), main="Simulation of various bets in punto banco baccarat")
lines(house_no_c_sim,lwd=2,col="darkorange")
lines(player_sim,lwd=2,col="blue")
lines(tie_sim,lwd=2,col="forestgreen")
lines(pair_sim,lwd=2,col="purple")
lines(p_e_sim,lwd=2,col="hotpink")
legend("bottomleft", bg="transparent",legend=c("Banker (0.95-to-1)","Banker (1-to-1)","Player (1-to-1)",paste0("Tie (",tie_payout,"-to-1)"),paste0("Player pair (",pair_payout,"-to-1)"),paste0("Either pair (",e_pair_payout,"-to-1)")), lwd=c(2,2,2,2,2,2), col=c("red","darkorange","blue","forestgreen","purple","hotpink"), title="Bet Types")