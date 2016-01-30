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
    @get('playerHand').on 'stand', => @get('dealerHand').dealerPlay()
    
    @get('playerHand').on 'bust', => @trigger 'playerLoses', @
    @get('dealerHand').on 'bust', => @trigger 'dealerLoses', @

# this.get('dealerHand').on('bust', (function(_this) {
#   return function(playerContext) {
#     return _this.trigger('dealerLoses', _this);
#   };
# })(this));