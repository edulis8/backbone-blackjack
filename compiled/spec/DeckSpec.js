// Generated by CoffeeScript 1.10.0
(function() {
  var assert;

  assert = chai.assert;

  describe('deck', function() {
    var deck, hand;
    deck = null;
    hand = null;
    beforeEach(function() {
      deck = new Deck();
      return hand = deck.dealPlayer();
    });
    describe('hit', function() {
      return it('should give the last card from the deck', function() {
        assert.strictEqual(deck.length, 50);
        hand.hit();
        return assert.strictEqual(deck.length, 49);
      });
    });
    return describe('reset', function() {
      var appView;
      appView = null;
      beforeEach(function() {
        return appView = new AppView({
          model: new App()
        });
      });
      it('should refer to the same deck after the reset', function() {
        deck = appView.model.get('deck');
        appView.reset();
        return assert.strictEqual(appView.model.get('deck'), deck);
      });
      return it('should not reset the deck length (note, this test only works when the hands don\'t bust', function() {
        deck = appView.model.get('deck');
        assert.strictEqual(deck.length, 48);
        appView.model.get('playerHand').hit();
        assert.strictEqual(deck.length, 47);
        appView.reset();
        return assert.strictEqual(deck.length, 43);
      });
    });
  });

}).call(this);

//# sourceMappingURL=DeckSpec.js.map
