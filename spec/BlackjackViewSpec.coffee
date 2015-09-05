assert = chai.assert

describe 'Game Logic', ->
  deck = null
  hand = null
  app = null
  player = null
  dealer = null
  sandbox = null

  beforeEach ->
    app = new App()
    player = app.get 'playerHand'
    dealer = app.get 'dealerHand'
    deck = app.get 'deck'
    sandbox = sinon.sandbox.create()

  afterEach ->
    sandbox.restore()

  describe 'hit', ->
    it 'should bust if player goes over 21', ->
      sandbox.spy App.prototype, 'lose'
      player
        .hit() while player.minScore() <= 21
      expect(app.lose).to.have.been.called;

  describe 'stand', ->
    it 'should cause dealer to draw cards until his score is >= 17', ->
      player.stand()
      expect dealer.minScore()
        .to.be.above 16

    it 'should reflect a win properly', ->
      eightOfClubs = new Card {rank:8,suit:2}
      tenOfClubs = new Card {rank:10,suit:2}
      sevenOfClubs = new Card {rank:7,suit:2}

      player.reset [eightOfClubs, tenOfClubs]
      dealer.reset [sevenOfClubs, tenOfClubs]
      console.log player
      sandbox.spy App.prototype, 'win'

      player
        .stand()

      expect(app.win).to.have.been.called;

    it 'should reflect a loss properly', ->
      eightOfClubs = new Card {rank:8,suit:2}
      tenOfClubs = new Card {rank:10,suit:2}
      sevenOfClubs = new Card {rank:7,suit:2}

      player.reset [sevenOfClubs, tenOfClubs]
      dealer.reset [eightOfClubs, tenOfClubs]
      sandbox.spy App.prototype, 'lose'

      player
        .stand()

      expect(app.lose).to.have.been.called;


    it 'should reflect a tie properly', ->
      eightOfClubs = new Card {rank:8,suit:2}
      tenOfClubs = new Card {rank:10,suit:2}
      sevenOfClubs = new Card {rank:7,suit:2}

      player.reset [sevenOfClubs, tenOfClubs]
      dealer.reset [sevenOfClubs, tenOfClubs]
      sandbox.spy App.prototype, 'tie'

      player
        .stand()

      expect(app.tie).to.have.been.called;

