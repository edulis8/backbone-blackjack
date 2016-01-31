# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.

# APP SHOULD CONTROL GAME FLOW BETWEEN VARIOUS PLAYERS

class window.App extends Backbone.Model
  initialize: (deckparam) ->
    @set 'deck', deck = deckparam ? new Deck()
    # DEALERHAND AND PLAYERHAND ARE SUBORDINATE TO APP
    # generate a playerHand using deck's method
    @set 'playerHand', deck.dealPlayer()
    # generate a dealerHand using deck's method
    @set 'dealerHand', deck.dealDealer()

    # listener for stand
    # SOLUTION: has listeners for busts and stands for both players here
    @get('playerHand').on 'stand', => 
      @get('dealerHand').dealerPlay()
      @findWinner()

  findWinner: ->
    dealerScores = @get('dealerHand').scores()
    dealerScore = if dealerScores[1] <= 21 then dealerScores[1] else dealerScores[0]
    playerScores = @get('playerHand').scores()
    playerScore = if playerScores[1] <= 21 then playerScores[1] else playerScores[0]
    
    if playerScore > dealerScore then alert('You Win!')
    if dealerScore > playerScore and dealerScore <= 21 then alert('You Lose!')
    if dealerScore == playerScore then alert('Tie!')

    ## IN SOLUTIONS
    ## LOGIC PRODUCES TRIGGERS:
    ## @trigger 'win-player' or 'win-dealer' or 'tie'


    @trigger 'game-over'     