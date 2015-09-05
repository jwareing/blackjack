class window.AppView extends Backbone.View
  template: _.template '
    <img class="table" src="img/table1.png">
    <div class="dealer-hand-container"></div>
    <div class="player-hand-container"></div>
    <a class="btn-floating btn-large waves-effect waves-light blue hit-button">HIT</a>
    <a class="btn-floating btn-large waves-effect waves-light green stand-button">STAND</a>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$el.addClass 'background'
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

