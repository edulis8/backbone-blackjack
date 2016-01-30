class window.Hand extends Backbone.Collection
  model: Card

  #[] []

  initialize: (array, @deck, @isDealer) ->


  hit: ->
    @add(@deck.pop())

  stand: ->
    console.log('stand')
    @trigger 'stand', @

  dealerPlay: (playerScore) ->
    # if scores[0] or scores[1] < 17
    # hit
    @at(0).flip()
    console.log(@scores()[0], @scores()[1])
    debugger;
    if @scores()[0] or @scores()[1] < 17 then @hit()

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0
  # adding up the scores on the revealed cards
  # this.reduce
  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

      # 6 , ace
      # 7 or 17


