# BACCARAT SIMULATION (PUNTO BANCO)
# =======================================
# SETTINGS
# Number of decks: usually 6 to 8
number_of_decks <- 8

# Banker commission: if set to TRUE, this is standard punto banco where 19 to 20 is paid on banker wins (5% commission)
# if set to FALSE this is Commission Free Baccarat or Nepal Bacarat where winning banker pays 1 to 1 except 1 to 2 on a winning total of six.
house_commission <- FALSE

# Tie payout: Usually 8 to 1 or 9 to 1 (set to 8 or 9)
tie_payout <- 8

# Pair payout: Usually 11 to 1
pair_payout <- 11

# Either pair payout: Usually 5 to 1
e_pair_payout <- 5
# =======================================


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

# checks if a hand of 2 has a pair
pairs <- function(hand) {
  if (hand[[1]] == hand[[2]]) {
    pair <- TRUE
  } else {
    pair <- FALSE
  }
  return(pair)
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
winner <- function(results,house_commission) {
  # 0 = banker, 1 = player, 2 = tie, 3 = banker wins with 6 (pays half on commission free baccarat)
  if (results[[3]] == results[[4]]) {
    winner <- 2
  } else if (results[[3]] > results[[4]]) {
    winner <- 1
  } else if (results[[4]] > results[[3]]) {
    if (results[[4]] == 6 && house_commission == FALSE) {
      winner <- 3
    } else {
      winner <- 0
    }
  }
  return(winner)
}

# calculates the payout to player (excluding pair bets)
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
  } else if (winner == 3) {
      payout <- house_bet*1.5
  }

  
  return(payout)
}

# One round of baccarat
round <- function(player_bet,house_bet,tie_bet,pair_player_bet,pair_house_bet,pair_either_bet,house_commission,tie_payout,pair_payout,e_pair_payout) {
  
  # Check if reshuffling is needed
  reshuffle()
  
  # Draw cards
  p_hand <- draw_card() # player draws first
  b_hand <- draw_card() # banker draws second
  p_hand <- c(p_hand, draw_card()) # player draws next card
  b_hand <- c(b_hand, draw_card()) # banker draws next card
  
  # Check for pairs
  pair_p <- pairs(p_hand)
  pair_b <- pairs(b_hand)
  
  # Value hands
  p_value <- value_hand(p_hand)
  b_value <- value_hand(b_hand)
  
  # Tableau rules
  play <- tableau(p_hand,b_hand,p_value,b_value) 
  
  # Calculates winner
  winner <- winner(play,house_commission)
  
  # Calculates winnings
  # If neither initial hand is a pair
  if (pair_p == FALSE && pair_b == FALSE) {
    winnings <- payout(winner,player_bet,house_bet,tie_bet,house_commission,tie_payout)
  } 
  # If we have at least one pair payout, check both
  else {
    if (pair_p) {
      winnings <- payout(winner,player_bet,house_bet,tie_bet,house_commission,tie_payout) + pair_player_bet*(1+pair_payout)
    }
    if (pair_b) {
      winnings <- payout(winner,player_bet,house_bet,tie_bet,house_commission,tie_payout) + pair_house_bet*(1+pair_payout)
    }
    # Either pair bet would also win
    winnings <- winnings + pair_either_bet*(1+e_pair_payout)
  }
  
  # Calculates profit on this round
  profit <- winnings - player_bet - house_bet - tie_bet - pair_player_bet - pair_house_bet
  
  
  print(paste("Bet on player:",player_bet,"| Bet on banker:",house_bet,"| Bet on tie:",tie_bet))
  if (pair_player_bet != 0 || pair_house_bet != 0 || pair_either_bet !=0 ) {
    print(paste("Bet on player pair:",pair_player_bet,"| Bet on banker pair:",pair_house_bet,"| Bet on either pair:",pair_either_bet))
  }
  print(paste("Player's hand:",paste(play[[1]], collapse=','),"| Value:",play[[3]]))
  print(paste("Banker's hand:",paste(play[[2]], collapse=','),"| Value:",play[[4]]))
  if (winner == 2){
    print("Result: Tie")
  } else if (winner == 1) {
    print("Result: Player wins")
  } else if (winner == 0) {
    print("Result: Banker wins")
  } else if (winner == 3) {
    print("Result: Banker wins with total six, pays 1 to 2")
  }
  if (pair_either_bet != 0 && (pair_p | pair_b)) {
    print("Either pair bet wins")
  }
  if (pair_player_bet != 0 && pair_p) {
    print("Pair bet on player wins")
  }
  if (pair_house_bet != 0 && pair_b) {
    print("Pair bet on banker wins")
  }
  print(paste("Payout:",winnings,"| Profit/Loss:",profit))
  round_stats <- c(winnings, winner)
  invisible(round_stats)
}


# Simulation
simulation <- function(n,open_bal,player_bet,house_bet,tie_bet,pair_player_bet,pair_house_bet,pair_either_bet,house_commission,tie_payout,pair_payout,e_pair_payout) {
  cash <- open_bal
  balance <- cash
  player_wins <- 0
  banker_wins <- 0
  ties <- 0
  print("=========================================")
  print("Punto banco baccarat")
  print(paste("Commission:",house_commission,"| Tie payout:",tie_payout,"to 1"))
  for (i in 1:n) {
    cash <- cash - player_bet - house_bet - tie_bet - pair_player_bet - pair_house_bet - pair_either_bet
    print("=========================================")
    print(paste("Coup",i))
    win <- round(player_bet,house_bet,tie_bet,pair_player_bet,pair_house_bet,pair_either_bet,house_commission,tie_payout,pair_payout,e_pair_payout)
    cash <- cash + win[[1]]
    balance <- c(balance, cash)
    print(paste("New cash balance:",cash))
    if (win[[2]] == 0 || win[[2]] == 3) {
      banker_wins <- banker_wins + 1
    } else if (win[[2]] == 1) {
      player_wins <- player_wins + 1
    } else if (win[[2]] == 2) {
      ties <- ties + 1
    }
  }
  print("=========================================")
  print(paste("Final cash balance:",cash))
  print(paste("Summary:",player_wins,"player wins,",banker_wins,"banker wins, and",ties,"ties."))
  print("=========================================")
  invisible(balance)
}


