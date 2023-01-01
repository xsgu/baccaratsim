# Simulation
simulation_with_shoe <- function(n,open_bal,player_bet,house_bet,tie_bet,pair_player_bet,pair_house_bet,pair_either_bet,house_commission,tie_payout,pair_payout,e_pair_payout) {
  cash <- open_bal
  balance <- cash
  player_wins <- 0
  banker_wins <- 0
  ties <- 0
  shoe <- 1
  
  outcome_table <- as.data.frame(matrix(nrow = n, ncol = 12))
  colnames(outcome_table) <- c("Shoe", "Coup", "Player card 1", "Player card 2", "Player card 3", "Banker card 1", "Banker card 2", "Banker card 3", "Player total", "Banker total", "Winner", "Pair outcome")  
  
  outcome_table$Coup <- seq(1, n)
  
  print("=========================================")
  print("Punto banco baccarat simulation")
  print(paste("Commission:",house_commission,"| Tie payout:",tie_payout,"to 1"))
  print(paste("Player/banker pair payout:",pair_payout,"to 1","| Either pair payout:",e_pair_payout,"to 1"))
  for (i in 1:n) {
    cash <- cash - player_bet - house_bet - tie_bet - pair_player_bet - pair_house_bet - pair_either_bet
    print("=========================================")
    print(paste("Coup",i))
    win <- round(player_bet,house_bet,tie_bet,pair_player_bet,pair_house_bet,pair_either_bet,house_commission,tie_payout,pair_payout,e_pair_payout)
    if (as.numeric(win[13]) == 1) {
      shoe <- shoe + 1
    }
    cash <- cash + as.numeric(win[1])
    balance <- c(balance, cash)
    print(paste("New cash balance:",cash))
    if (as.numeric(win[2]) == 0 || as.numeric(win[2]) == 3) {
      banker_wins <- banker_wins + 1
    } else if (as.numeric(win[2]) == 1) {
      player_wins <- player_wins + 1
    } else if (as.numeric(win[2]) == 2) {
      ties <- ties + 1
    }
    
    # Populate the table of outcomes
    outcome_table[i,1] <- shoe
    outcome_table[i,3:5] <- win[5:7]  # player cards
    outcome_table[i,6:8] <- win[8:10] # banker cards
    outcome_table[i,9:10] <- win[11:12] # player and banker total
    outcome_table[i,11:12] <- win[3:4] # outcomes
  }
  print("=========================================")
  print(paste("Final cash balance:",cash))
  print(paste("Summary:",player_wins,"player wins,",banker_wins,"banker wins, and",ties,"ties."))
  print("=========================================")
  invisible(list(balance, outcome_table))
}

# Example using simulation_with_shoe
# Start with a full deck
deck <- full_deck

# Set up the bets
player_bet <- 0
house_bet <- 50
tie_bet <- 0
pair_player_bet <- 0
pair_house_bet <- 0
pair_either_bet <- 0
n <- 500
open_bal <- 5000

# Call the simulation_with_shoe function and write the results to a table
outcome_table_shoe <- simulation_with_shoe(n,open_bal,player_bet,house_bet,tie_bet,pair_player_bet,pair_house_bet,pair_either_bet,house_commission,tie_payout,pair_payout,e_pair_payout)[[2]]
write.csv(outcome_table_shoe, "sampletables/sample_outcome_table_shoe.csv", row.names=FALSE)