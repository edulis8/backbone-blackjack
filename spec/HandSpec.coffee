assert = chai.assert

describe 'Hand', ->
  deck = null
  playerHand = null
  dealerHand = null
  
  beforeEach ->
   deck = new Deck()
   playerHand = deck.dealPlayer()
   dealerHand = deck.dealDealer()   
  
  describe 'hit', ->
    
    
    it 'should decrease the size of the deck by 1, and increase the hand by 1', ->
      assert.strictEqual deck.length, 48
      playerHand.hit()
      assert.strictEqual deck.length, 47
      assert.strictEqual playerHand.length, 3

    it 'should not hit after score is 21', ->
      while playerHand.scores()[0] < 21 || playerHand.scores()[1] < 21
        playerHand.hit()

      score0 = playerHand.scores()[0]
      score1 = playerHand.scores()[1]

      playerHand.hit()

      assert.strictEqual score0, playerHand.scores()[0]
      assert.strictEqual score1, playerHand.scores()[1]
      
    it 'should trigger the dealer to play on "stand" (first card flipped)', ->
      playerHand.stand()
      setTimeout ->
        assert.strictEqual dealerHand.at(0).get('revealed'), true
      , 5
      
    it 'should make the dealer hit until they have a score >= 17', ->
      i = 0
      while i < 100
        deck = new Deck()
        dealerHand = deck.dealDealer()
        dealerHand.dealerPlay()
        test = dealerHand.scores()[0] >= 17 or dealerHand.scores()[1] >= 17
        assert.strictEqual test, true
        i++
      
      


    