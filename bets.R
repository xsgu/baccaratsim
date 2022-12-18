# This requires the baccaratsim.R file to be run first.

# ====================
# Plays a single round of baccarat
# Change the bets to your desired bet amounts.
# ====================
player_bet <- 0
house_bet <- 0
tie_bet <- 0
pair_player_bet <- 0
pair_house_bet <- 0
pair_either_bet <- 10
round(player_bet,house_bet,tie_bet,pair_player_bet,pair_house_bet,pair_either_bet,house_commission,tie_payout,pair_payout,e_pair_payout)

# ====================
# Simulates n rounds of baccarat
# Change the bets to your desired bet amounts.
# ====================
player_bet <- 0
house_bet <- 50
tie_bet <- 0
pair_player_bet <- 0
pair_house_bet <- 0
pair_either_bet <- 0
n <- 100
open_bal <- 5000
simulation(n,open_bal,player_bet,house_bet,tie_bet,pair_player_bet,pair_house_bet,pair_either_bet,house_commission,tie_payout,pair_payout,e_pair_payout)

# ====================
# Table of outcomes in the above simulation
# If you want to output a table of all the outcomes in the simulation, run this below chunk
# ====================
outcome_table <- simulation(n,open_bal,player_bet,house_bet,tie_bet,pair_player_bet,pair_house_bet,pair_either_bet,house_commission,tie_payout,pair_payout,e_pair_payout)[[2]]
write.csv(outcome_table, "sampletables/sample_outcome_table.csv", row.names=FALSE)




# =======================
# Let's see how the various types of bets work out
# This simulation below runs n coups (i.e. hands) for each type of bet and charts the profit/loss as each coup progresses.
# =======================
# SETTINGS
# ====== EDIT BELOW =====
n <- 5000
open_bal <- 0  # set to 0 to see profit-loss chart, otherwise it acts like a starting cash balance
# Payouts can be changed at the top of the baccaratsim.R file
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
invisible(capture.output(house_c_sim <- simulation(n,open_bal,player_bet,house_bet,tie_bet,pair_player_bet,pair_house_bet,pair_either_bet,house_commission,tie_payout,pair_payout,e_pair_payout)[[1]]))

# Second, betting on the house without commissions
house_commission <- FALSE
invisible(capture.output(house_no_c_sim <- simulation(n,open_bal,player_bet,house_bet,tie_bet,pair_player_bet,pair_house_bet,pair_either_bet,house_commission,tie_payout,pair_payout,e_pair_payout)[[1]]))

# Third, betting on the player
house_commission <- TRUE
player_bet <- 100
house_bet <- 0
tie_bet <- 0
invisible(capture.output(player_sim <- simulation(n,open_bal,player_bet,house_bet,tie_bet,pair_player_bet,pair_house_bet,pair_either_bet,house_commission,tie_payout,pair_payout,e_pair_payout)[[1]]))

# Fourth, betting on tie
player_bet <- 0
house_bet <- 0
tie_bet <- 100
invisible(capture.output(tie_sim <- simulation(n,open_bal,player_bet,house_bet,tie_bet,pair_player_bet,pair_house_bet,pair_either_bet,house_commission,tie_payout,pair_payout,e_pair_payout)[[1]]))

# Fifth, betting on player pair
player_bet <- 0
house_bet <- 0
tie_bet <- 0
pair_player_bet <- 100
invisible(capture.output(pair_sim <- simulation(n,open_bal,player_bet,house_bet,tie_bet,pair_player_bet,pair_house_bet,pair_either_bet,house_commission,tie_payout,pair_payout,e_pair_payout)[[1]]))

# Sixth, betting on banker pair
player_bet <- 0
house_bet <- 0
tie_bet <- 0
pair_player_bet <- 0
pair_house_bet <- 100
invisible(capture.output(pair_house_sim <- simulation(n,open_bal,player_bet,house_bet,tie_bet,pair_player_bet,pair_house_bet,pair_either_bet,house_commission,tie_payout,pair_payout,e_pair_payout)[[1]]))

# Seventh, betting on either pair
pair_house_bet <- 0
pair_either_bet <- 100
invisible(capture.output(p_e_sim <- simulation(n,open_bal,player_bet,house_bet,tie_bet,pair_player_bet,pair_house_bet,pair_either_bet,house_commission,tie_payout,pair_payout,e_pair_payout)[[1]]))

# Plot
options("scipen" = 999)
ymin <- min(house_c_sim,house_no_c_sim,player_sim,tie_sim,pair_sim,pair_house_sim,p_e_sim)
ymax <- max(house_c_sim,house_no_c_sim,player_sim,tie_sim,pair_sim,pair_house_sim,p_e_sim)

png(filename = "sampleplots/bets.png", width = 1280, height = 640)
plot(house_c_sim,type="l",lwd=2,col="red",ylab="Profit / Loss",xlab="Coup",ylim=c(ymin,ymax), main="Simulation of various bets in punto banco baccarat")
lines(house_no_c_sim,lwd=2,col="darkorange")
lines(player_sim,lwd=2,col="blue")
lines(tie_sim,lwd=2,col="forestgreen")
lines(pair_sim,lwd=2,col="purple")
lines(pair_house_sim,lwd=2,col="brown")
lines(p_e_sim,lwd=2,col="hotpink")
legend("bottomleft", 
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
       col=c("red","darkorange","blue","forestgreen","purple","brown","hotpink"), 
       title="Bet Types")
dev.off()