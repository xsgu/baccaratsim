# Baccarat Simulation

A simulation of punto banco (North American style) baccarat in R. Latest version tested on R 3.4.1 (2017-06-30).

Gameplay Features:

1. Uses standard drawing and tableau rules.
2. Allows standard bets (player, banker, tie), player/banker pair bets (wins when first two cards dealt are a pair), and an either pair bet (wins when either player or banker's first two cards dealt are a pair).)
3. Tie pushes all player and banker bets.
4. Cut card is placed in front of the 6th last card.
5. Can adjust the number of decks used (usually 6 to 8).
6. Can turn on or off house commission for banker wins (commission set to 0.95). 
7. Can adjust the payout for ties (usually pays 8:1 or 9:1).
8. Can adjust the payout for pair bets (usually pays 11:1).
9. Can adjust the payout for an either pair bet (usually pays 5:1).


Code Features:
1. The code does not use any R packages. It can be run on a base R installation.


## baccaratsim
1. Contains all of the functions to run the baccarat simulation. Run this file first.


## bets
1. Simulate a single round of baccarat with *round()*.
2. Simulate n rounds of baccarat with with *simulation()*.
3. Simulate n rounds of baccarat with various types of bets, showing how the results differ.


## density
1. Simulates r sessions of n rounds of baccarat with a specific bet, and displays a histogram or density plot of the profit/loss at the end of each session.


## A brief explanation of punto banco baccarat

*Credit to [Wikipedia](https://en.wikipedia.org/wiki/Baccarat_(card_game)#Punto_banco).*

In baccarat, cards have a point value: cards two through nine are worth face value (in points); tens, jacks, queens and kings have no point value (i.e. are worth zero); aces are worth 1 point; jokers are not used. Hands are valued according to the rightmost digit of the sum of their constituent cards. For example, a hand consisting of 2 and 3 is worth 5, but a hand consisting of 6 and 7 is worth 3 (i.e., the 3 being the rightmost digit in the combined points total of 13). The highest possible hand value in baccarat is therefore nine.

Punto banco is dealt from a shoe containing 6 or 8 decks of cards shuffled together with 8 decks being most commonly used. A cut-card—a coloured (often yellow) piece of plastic, the same size as a regular card, and which is used in shuffling—is placed in front of the seventh-last card, and the drawing of the cut-card indicates the last coup of the shoe. For each coup, two cards are dealt face up (or equivalent) to each hand, starting from "player" and alternating between the hands. The croupier may call the total (e.g. "Five Player, three Banker"). If either Player or Banker or both achieve a total of 8 or 9 at this stage, the coup is finished and the result is announced: Player win, a Banker win, or tie. If neither hand has eight or nine, the drawing rules are applied to determine whether Player should receive a third card. Then, based on the value of any card drawn to the player, the drawing rules are applied to determine whether the Banker should receive a third card. The coup is then finished, the outcome is announced, and winning bets are paid out.

### Tableau of drawing rules
If neither the Player nor Banker is dealt a total of 8 or 9 in the first two cards (known as a "natural"), the tableau is consulted, first for Player's rule, then Banker's.

#### Player's rule
If Player has an initial total of 0–5, he draws a third card. If Player has an initial total of 6 or 7, he stands.

#### Banker's rule
* If Player stood pat (i.e., has only two cards), the banker regards only his own hand and acts according to the same rule as Player. That means Banker draws a third card with hands 0–5 and stands with 6 or 7.
* If Player drew a third card, the Banker acts according to the following more complex rules:
  * If Player drew a 2 or 3, Banker draws with 0–4 and stands with 5–7.
  * If Player drew a 4 or 5, Banker draws with 0–5 and stands with 6–7.
  * If Player drew a 6 or 7, Banker draws with 0–6 and stands with 7.
  * If Player drew an 8, Banker draws with 0–2 and stands with 3–7.
  * If Player drew an ace, 9, 10, or face-card, the Banker draws with 0–3 and stands with 4–7.

The croupier will deal the cards according to the tableau and the croupier will announce the winning hand: either Player or Banker. Losing bets will be collected and the winning bets will be paid according to the rules of the house. Usually, even money or 1–to-1 will be paid on Player bets and 95% or 19-to-20 on Banker bets (even money with "5% commission to the house on the win").

Should both Banker and Player have the same value at the end of the deal the croupier shall announce "égalité — tie bets win." All tie bets will be paid at 8-to-1 odds and all bets on Player or Banker remain in place and active for the next game (the customer may or may not be able to retract these bets depending on casino rules).

## Expected mathematical returns
*Credit to [The Wizard of Odds](https://wizardofodds.com/games/baccarat/basics/).*

* Expected theoretical returns with 8 decks:
  * Banker (commission): -0.010579
  * Player: -0.012351
  * Player or banker pair (pays 11-to-1): -0.103614
  * Either pair (pays 5-to-1) : -0.137099
  * Tie bet (pays 8-to-1): -0.143596

* Expected theoretical returns with 6 decks:
  * Banker (commission): -0.010558
  * Player: -0.012374
  * Player or banker pair (pays 11-to-1): -0.11254
  * Either pair (pays 5-to-1) : -0.145365
  * Tie bet (pays 8-to-1): -0.144382
  
## Release history

### Version 2.1 (Atlantic City)

December 18, 2022

1. Fixed an issue in *simulation()* where the either pair bet was not being subtracted from the cash balance.
2. *simulation()* now also returns a table of outcomes, showing the player cards dealt, banker cards dealt, player and banker card totals, and the outcome.

Tested on R version 4.2.2 (2022-10-31).

### Version 2.0 (Atlantic City)

August 12, 2017

1. Implemented support for player/banker pair and either pair side bets, as well as the ability to change the payout for these bets.
2. No commission or commission-free baccarat now correctly pays 1-to-2 (0.5-to-1) for winning banker hand with total six.
3. Summary statistics added at the end of *simulation()*.
4. Changed wording to better reflect actual baccarat nomenclature.

Tested on R version 3.4.1 (2017-06-30).

### Version 1.0 (Macau)

August 11, 2017

1. Implemented basic game, drawing rules, house commission toggle, number of decks, tie payout, simulation plots.

Tested on R version 3.3.2 (2016-10-31).
