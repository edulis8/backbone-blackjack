# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: (deckparam) ->
    @set 'deck', deck = deckparam ? new Deck()
    # generate a playerHand using deck's method
    @set 'playerHand', deck.dealPlayer()
    # generate a dealerHand using deck's method
    @set 'dealerHand', deck.dealDealer()

    # listener for stand
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

    @trigger 'game-over'     