# Baccarat Simulation

A simulation of punto banco (North American style) baccarat.

1. Uses standard drawing and tableau rules.
2. Can adjust the number of decks used (usually 6 to 8).
3. Cut card is placed before the 7th card.
4. Can turn on or off house commission for banker wins (set to 0.95). 
5. Can adjust the payout for ties (usually pays 8:1 or 9:1).


## baccaratsim
Contains all of the functions to run the baccarat simulation. Run this file first.


## bets
1. Simulate a single round of baccarat with *round()*.
2. Simulate n rounds of baccarat with with *simulation()*.
3. Simulate n rounds of baccarat with various types of bets, showing how the results differ.


## density
Displays a histogram or density plot of the various types of bets.


## An explanation of punto banco baccarat

*Credit to [Wikipedia](https://en.wikipedia.org/wiki/Baccarat_(card_game)#Punto_banco).*

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

## To be implemented at a later date
* Player and banker pair bets (pays 11:1).
