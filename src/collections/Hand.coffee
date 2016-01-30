class window.Hand extends Backbone.Collection
  model: Card
  # a collection of card models [] [] [] with 'revealed', suitName, value etc
  initialize: (array, @deck, @isDealer) ->


  hit: ->
    if @scores()[0] < 21 or @scores()[1] < 21 then @add(@deck.pop())

    if @scores()[0] > 21 then @bust()
    # trigger(s) here for game ending

  stand: ->
    @trigger 'stand', @

  bust: ->
    @trigger 'bust', @

  dealerPlay: () ->
    if @at(0).get('revealed') != true then @at(0).flip()

    while @scores()[0] < 17 and @scores()[1] < 17 then @hit()

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0
  # adding up the scores on the revealed cards
  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]
