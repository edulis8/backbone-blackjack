# NORMALLY THE APPVIEW WOULD INTERACTE DIRECTLY WITH ITS MODEL AND THE MODEL WOULD TRANSLATE INTENT TO SUBORDINATE MODELS, BUT HERE THAT IS BYPASSED AND WE GO TO HANDMODEL DIRECTLY FROM APPVIEW

class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()

  initialize: ->
    # Listeners for triggers from the hands.
    # SOLUTION: THIS IS IN APP, NOT HERE
    @model.get('playerHand').on 'bust', => 
      alert 'You busted!!!'
      @reset()      

    @model.get('dealerHand').on 'bust', => 
      alert 'Dealer busted!!!'
      @reset()
    
    @model.on 'game-over', @reset, @
    # WHEN LISTENING TO MANY EVENTS: @model.on 'all', @reset, @
    # AND PUT A PARAMETER IN RESET CALLED EVENT, MAKE CASES/IF STATEMENTS
    # THAT CORRESPOND TO NAMES OF TRIGGERS
  
    # @model.get('playerHand').on 'stand', => 
    #   @model.get('dealerHand').dealerPlay()
    #   @events['click .hit-button'] = -> alert('No.')
  
    @render()

  reset: ->
      if confirm 'Want to play again?' then @model = new App(@model.get('deck'))
      @initialize()
      @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

