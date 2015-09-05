class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    @
      .on 'change add reset', =>
        @scores()
        @checkBust()

  hit: ->
    @add(@deck.pop())
    @last()

  stand: ->
    @trigger('stand')

  double: ->
    @trigger('double')


  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  revealFirst: ->
    @at 0
      .set 'revealed', true

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]


  checkBust: ->
    @trigger('bust') if @minScore() > 21
    if @minScore() > 21
      true
    else
      false

  bestScore: ->
    if @scores()[1] <= 21
       @scores()[1]
      else
        @scores()[0]