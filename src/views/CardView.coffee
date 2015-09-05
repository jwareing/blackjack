class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<img class="back" src="img/card-back.png">\
    <img class="front" src="img/PNG-cards-1.3/<%= rankName %>_of_<%= suitName %>.png">'

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

