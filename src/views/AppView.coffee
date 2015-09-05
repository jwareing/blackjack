class window.AppView extends Backbone.View
  template: _.template '
    <img class="table" src="img/table1.png">
    <div class="dealer-hand-container"></div>
    <div class="player-hand-container"></div>
    <div class="chip-container"></div>

    <a class="btn-floating btn-large waves-effect waves-light blue hit-button">HIT</a>
    <a class="btn-floating btn-large waves-effect waves-light green stand-button">STAND</a>
    <a class="btn-floating btn-large waves-effect waves-light red double-button">DOUBLE</a>
    <a class="btn-floating btn-large waves-effect waves-light red deal-button">DEAL</a>
      <div id="win-modal" class="modal">
          <div class="modal-content">
              <h4>You win!</h4>
          </div>
          <div class="modal-footer">
              <a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat reset-button">Play Again?</a>
          </div>
      </div>
      <div id="lose-modal" class="modal">
          <div class="modal-content">
              <h4>You lose!</h4>
          </div>
          <div class="modal-footer">
              <a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat reset-button">Play Again?</a>
          </div>
      </div>
      <div id="tie-modal" class="modal">
          <div class="modal-content">
              <h4>You tied!</h4>
          </div>
          <div class="modal-footer">
              <a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat reset-button">Play Again?</a>
          </div>
      </div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .double-button': -> 
      betAmount = @model.get 'betAmount'
      bank = @model.get 'bank'
      if (betAmount) <= (bank)
        @model.set 'betAmount', betAmount*2
        @model.set 'bank', bank-betAmount
        player = @model.get 'playerHand'
        player.hit()
        player.stand() if not player.checkBust()

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.hit-button').hide()
    @$('.stand-button').hide()
    @$('.double-button').hide()
    @$('.chip-container').html new ChipView(model: @model).el
    @$('.deal-button').on 'click', () =>
      @$('.deal-button').hide()
      @model.redeal()
      @renderCards()
    @$('.reset-button').on 'click', () =>
      console.log 'reset'
      @render()

  renderCards: ->
    @$('.hit-button').show()
    @$('.stand-button').show()
    @$('.double-button').show()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el