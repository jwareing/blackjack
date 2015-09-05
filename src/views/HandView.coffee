class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<p class ="score-text"><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</p>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.scores()[0]

