# BACCARAT SIMULATION (PUNTO BANCO)

# SETTINGS
# Number of decks: usually 6 to 8
number_of_decks <- 8

# Banker commission: if set to TRUE, 1-to-1 minus 5% commission to the house will be paid on banker wins, otherwise pays 1-to-1
house_commission <- TRUE

# Tie payout: Usually 8 to 1 or 9 to 1 (set to 8 or 9)
tie_payout <- 8

# Pair payout: Usually 11 to 1
pair_payout <- 11 # to be implemented later






# Create our deck
cards <- c(rep(c("A","K","Q","J",10,9,8,7,6,5,4,3,2),4))
deck <- rep(cards, number_of_decks)

# Store the full deck to use when reshuffling
full_deck <- deck

# values a card
value_card <- function(card) {
  if (card == "A")
  {
    value <- 1
  }
  else if (card == "K" || card == "Q" || card == "J" || card == "10")
  {
    value <- 0
  }
  else
  {
    value <- as.numeric(card)
  }
  return(value)
}

# values a hand
value_hand <- function(hand) {
  value <- 0
  for (i in hand) {
    value <- value + value_card(i)
  }
  value <- value %% 10
}

# draws a card
draw_card <- function() 
{
  card <- sample(deck, 1, replace=F)
  if (is.element(card, deck))
  {
    deck <<- deck[-match(card,deck)] # global
  }    
  return(card)
}

# check if we need to reshuffle after each round
reshuffle <- function()
{
  if (length(deck) < 7) { # cut card is placed in front of the seventh last card
    deck <<- full_deck
  }
}


# Tableau rules
tableau <- function(p_hand,b_hand,p_value,b_value) {
  
  # Drawing rules
  # Natural - neither side draws
  if (p_value > 7 || b_value > 7) {
    p_draw <- FALSE
    b_draw <- FALSE
  } 
  
  # Player has 6 or 7, stands
  else if (p_value > 5) {
    p_draw <- FALSE
    if (b_value > 5) {
      b_draw <- FALSE
    } else {
      b_draw <- TRUE
    }
  }
  
  # Player has 0 to 5, draws a third card
  else {
    p_draw <- TRUE
    p_card <- draw_card()
    p_card_value <- value_card(p_card)
    p_hand <- c(p_hand, p_card)
    p_value <- value_hand(p_hand)
    b_draw <- FALSE
    if (b_value <= 2) {
      b_draw <- TRUE
    } else if (b_value == 3 && p_card_value != 8) {
      b_draw <- TRUE
    } else if (b_value == 4 && p_card_value >= 2 && p_card_value <= 7) {
      b_draw <- TRUE
    } else if (b_value == 5 && p_card_value >= 4 && p_card_value <= 7) {
      b_draw <- TRUE
    } else if (b_value == 6 && p_card_value >= 6 && p_card_value <= 7) {
      b_draw <- TRUE
    }
  }
  
  if (b_draw == TRUE) {
    b_card <- draw_card()
    b_card_value <- value_card(b_card)
    b_hand <- c(b_hand, b_card)
    b_value <- value_hand(b_hand)
  }
  
  results <- list(p_hand,b_hand,p_value,b_value,p_draw,b_draw)
  return(results)
}

# calculates the winner
winner <- function(results) {
  # 0 = banker, 1 = player, 2 = tie
  if (results[[3]] == results[[4]]) {
    winner <- 2
  } else if (results[[3]] > results[[4]]) {
    winner <- 1
  } else if (results[[4]] > results[[3]]) {
    winner <- 0
  }
  return(winner)
}

# calculates the payout to player
payout <- function(winner,player_bet,house_bet,tie_bet,house_commission,tie_payout) {
  
  # Winner payouts
  if (winner == 2) {
    payout <- tie_bet*(1 + tie_payout) + player_bet + house_bet
  } else if (winner == 1) {
    payout <- player_bet*2
  } else if (winner == 0) {
    if (house_commission == TRUE) {
      payout <- house_bet*1.95
    } else {
      payout <- house_bet*2
    }
  }
  
  # Pair payouts - to be implemented
  
  return(payout)
}

# One round of baccarat
round <- function(player_bet,house_bet,tie_bet,house_commission,tie_payout) {
  
  # Check if reshuffling is needed
  reshuffle()
  
  # Draw cards
  p_hand <- draw_card()
  p_hand <- c(p_hand, draw_card())
  b_hand <- draw_card()
  b_hand <- c(b_hand, draw_card())
  
  # Value hands
  p_value <- value_hand(p_hand)
  b_value <- value_hand(b_hand)
  
  # Tableau rules
  play <- tableau(p_hand,b_hand,p_value,b_value) 
  
  # Calculates winner
  winner <- winner(play)
  
  # Calculates winnings and profit
  winnings <- payout(winner,player_bet,house_bet,tie_bet,house_commission,tie_payout)
  profit <- winnings - player_bet - house_bet - tie_bet
  
  print(paste("Bet on player:",player_bet,"| Bet on banker:",house_bet,"| Bet on tie:",tie_bet))
  print(paste("Player's hand:",paste(play[[1]], collapse=','),"| Value:",play[[3]]))
  print(paste("Banker's hand:",paste(play[[2]], collapse=','),"| Value:",play[[4]]))
  if (winner == 2){
    print("Result: Tie")
  } else if (winner == 1) {
    print("Result: Player wins")
  } else if (winner == 0) {
    print("Result: Banker wins")
  }
  print(paste("Payout:",winnings,"| Profit/Loss:",profit))
  return(winnings)
}

# Plays a single round of baccarat
# Bets
# player_bet <- 10
# house_bet <- 0
# tie_bet <- 0
# round(player_bet,house_bet,tie_bet,house_commission,tie_payout)


# Simulation
simulation <- function(n,open_bal,player_bet,house_bet,tie_bet,house_commission,tie_payout) {
  cash <- open_bal
  balance <- cash
  print("=========================================")
  print("Punto banco baccarat")
  print(paste("House commission:",house_commission,"| Tie payout:",tie_payout,"to 1"))
  for (i in 1:n) {
    cash <- cash - player_bet - house_bet - tie_bet
    print("=========================================")
    print(paste("Game",i))
    win <- round(player_bet,house_bet,tie_bet,house_commission,tie_payout)
    cash <- cash + win
    balance <- c(balance, cash)
    print(paste("New cash balance:",cash))
  }
  print("=========================================")
  print(paste("Final cash balance:",cash))
  return(balance)
}

# Simulates n rounds of baccarat
player_bet <- 0
house_bet <- 10
tie_bet <- 0
n <- 100
open_bal <- 500
simulation(n,open_bal,player_bet,house_bet,tie_bet,house_commission,tie_payout)
