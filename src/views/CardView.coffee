class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<img class="back" src="img/card-back.png">\
    <img class="front" src="img/cards/<%= rankName %>-<%= suitName %>.png">'

  initialize: -> 
    @render()

    @model.on 'flip', ->
      @$el.find '.back'
        .hide()
      @$el.find '.front'
        .show()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    if @model.get 'revealed'
      @$el.find '.back'
        .hide()
    else
      @$el.find '.front'
        .hide()

