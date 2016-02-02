// Generated by CoffeeScript 1.10.0
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  window.AppView = (function(superClass) {
    extend(AppView, superClass);

    function AppView() {
      return AppView.__super__.constructor.apply(this, arguments);
    }

    AppView.prototype.template = _.template('<button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <div class="player-hand-container"></div> <div class="dealer-hand-container"></div>');

    AppView.prototype.events = {
      'click .hit-button': function() {
        return this.model.get('playerHand').hit();
      },
      'click .stand-button': function() {
        return this.model.get('playerHand').stand();
      }
    };

    AppView.prototype.initialize = function() {
      this.model.get('playerHand').on('bust', (function(_this) {
        return function() {
          alert('You busted!!!');
          return _this.reset();
        };
      })(this));
      this.model.get('dealerHand').on('bust', (function(_this) {
        return function() {
          alert('Dealer busted!!!');
          return _this.reset();
        };
      })(this));
      this.model.on('game-over', this.reset, this);
      return this.render();
    };

    AppView.prototype.reset = function() {
      if (confirm('Want to play again?')) {
        this.model = new App(this.model.get('deck'));
      }
      this.initialize();
      return this.render();
    };

    AppView.prototype.render = function() {
      this.$el.children().detach();
      this.$el.html(this.template());
      this.$('.player-hand-container').html(new HandView({
        collection: this.model.get('playerHand')
      }).el);
      return this.$('.dealer-hand-container').html(new HandView({
        collection: this.model.get('dealerHand')
      }).el);
    };

    return AppView;

  })(Backbone.View);

}).call(this);

//# sourceMappingURL=AppView.js.map
