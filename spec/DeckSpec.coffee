assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()
    

  describe 'hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 50
      hand.hit()
      assert.strictEqual deck.length, 49

  describe 'reset', ->
    appView = null
    
    beforeEach ->
      appView = new AppView(model: new App())
      
    
    it 'should refer to the same deck after the reset', ->
      deck = appView.model.get('deck') 
      appView.reset()
      assert.strictEqual appView.model.get('deck'), deck

    it 'should not reset the deck length (note, this test only works when the hands don\'t bust', ->
      deck = appView.model.get('deck')
      assert.strictEqual deck.length, 48       
      appView.model.get('playerHand').hit()
      assert.strictEqual deck.length, 47
      appView.reset()
      assert.strictEqual deck.length, 43
      