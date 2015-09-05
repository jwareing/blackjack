# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @redeal()
    @set 'bank', 150
    @set 'betAmount', 0

  redeal: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    player = @get 'playerHand'
    dealer = @get 'dealerHand'

    player
      .on 'bust', () =>
        @lose()

    player
      .on 'stand', () =>
        dealer
          .revealFirst()
        dealer
          .hit() until dealer.minScore() >= 17

        dScore = dealer.minScore()
        pScore = player.bestScore()
        if dScore > pScore and dScore <=21
          @lose()
        else if dScore == pScore
          @tie()
        else
          @win()

    player
      .on 'double', () =>
        @trigger 'double'

  lose: ->
    $('.lose-button').click();
    @set 'betAmount', 0


  win: ->
    $('.win-button').click();
    @set 'bank', (@get 'bank') + 2*(@get 'betAmount')
    @set 'betAmount', 0


  tie: ->
    $('.tie-button').click();
    @set 'bank', (@get 'bank') + (@get 'betAmount')
    @set 'betAmount', 0


  resetGame: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()