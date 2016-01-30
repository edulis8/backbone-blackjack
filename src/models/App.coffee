# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    # generate a playerHand using deck's method
    @set 'playerHand', deck.dealPlayer()
    # generate a dealerHand using deck's method
    @set 'dealerHand', deck.dealDealer()
    # listener for stand
    @get('playerHand').on 'stand', (score) => @get('dealerHand').dealerPlay(score)
      # console.log('heard the stand trigger')
      # @get('dealerHand').dealerPlay(score)
      # return undefined
    # this.on('stand', this.get('dealerHand').dealerPlay);

