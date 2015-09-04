# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    console.log @
    player = @get 'playerHand'
    dealer = @get 'dealerHand'

    player
      .on 'bust', () ->
        lose()

    player
      .on 'stand', () ->
        dealer
          .revealFirst()
        dealer
          .hit() while dealer.scores()[0] < 17

        dScore = dealer.scores()[0]
        if player.scores()[1] <= 21
          pScore = player.scores()[1]
        else
          pScore = player.scores()[0]
        if dScore > pScore and dScore <=21
          lose()
        else if dScore == pScore
          tie()
        else
          win()

    lose = () ->
      console.log 'you lost'

    win = () ->
      console.log 'you won'

    tie = () ->
      console.log 'you tied'