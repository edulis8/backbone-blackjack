class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'


  initialize: ->
    @collection.on 'add remove change', => @render()
    @render()

  render: ->
    if @collection.hasAce() > 0 then @aceScore = @collection.scores()[1] else @aceScore = ' '

    @$el.children().detach()
    
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.scores()[0] + ' ' + @aceScore
