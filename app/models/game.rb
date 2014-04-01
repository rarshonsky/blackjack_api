require 'deck'
require 'hand'

class Game
  include Virtus.model

  attribute :deck, Deck
  attribute :dealer_hand, Hand
  attribute :player_hand, Hand
  attribute :id

  def start
    self.deck = Deck.new
    self.deck.start
    self.deck.shuffle
    self.id = SecureRandom.uuid
    self.player_hand = Hand.new({cards: [self.deck.next], stay:false})
    self.dealer_hand = Hand.new({cards: [self.deck.next]})
    player_hit
    dealer_hit
  end

  def player_hit
    self.player_hand.add_card self.deck.next
  end

  def dealer_hit
    self.dealer_hand.add_card self.deck.next
  end

  def dealer_plays
    self.player_hand.stay = true
    while self.dealer_hand.total < 17 && !self.player_hand.has_blackjack?
      self.dealer_hit
    end
  end

  def game_over?
    if (self.player_hand.stay == true && self.dealer_hand.total > 17) || self.player_hand.bust? || self.dealer_hand.bust? || self.player_hand.has_blackjack? || self.dealer_hand.has_blackjack?
      return true
    end
    false
  end

  def data
    if self.player_hand.has_blackjack? && !self.dealer_hand.has_blackjack?
      { :player_total =>  self.player_hand.total.to_json, :player_cards => self.player_hand.to_json, :dealer_cards => self.dealer_hand.to_json, :dealer_total =>  self.dealer_hand.total.to_json, :winner => "Player blackjack" }
    elsif !self.player_hand.has_blackjack? && self.dealer_hand.has_blackjack?
      { :player_total =>  self.player_hand.total.to_json, :player_cards => self.player_hand.to_json, :dealer_cards => self.dealer_hand.to_json, :dealer_total => self.dealer_hand.total.to_json, :winner => "Dealer blackjack" }
    elsif !self.player_hand.has_blackjack? && self.dealer_hand.has_blackjack?
      { :player_total => self.player_hand.total.to_json, :player_cards => self.player_hand.to_json, :dealer_cards => self.dealer_hand.to_json, :dealer_total => self.dealer_hand.total.to_json, :winner => "Blackjack push" }
    elsif self.player_hand.bust?
      { :player_total =>  self.player_hand.total.to_json, :player_cards => self.player_hand.to_json, :dealer_cards => self.dealer_hand.to_json, :dealer_total => self.dealer_hand.total.to_json, :winner => "Dealer"}
    elsif self.dealer_hand.bust?
      { :player_total => self.player_hand.total.to_json, :player_cards => self.player_hand.to_json, :dealer_cards => self.dealer_hand.to_json, :dealer_total => self.dealer_hand.total.to_json, :winner => "Player"}
    elsif !self.player_hand.stay
      { :player_total =>  self.player_hand.total.to_json, :player_cards => self.player_hand.to_json, :dealer_cards => {:cards => [self.dealer_hand.cards.first.to_json]}}
    elsif self.dealer_hand.total > self.player_hand.total
      { :player_total => self.player_hand.total.to_json, :player_cards => self.player_hand.to_json, :dealer_cards => self.dealer_hand.to_json, :dealer_total => self.dealer_hand.total.to_json, :winner => "Dealer"}
    elsif self.dealer_hand.total == self.player_hand.total
      { :player_total => self.player_hand.total.to_json, :player_cards => self.player_hand.to_json, :dealer_cards => self.dealer_hand.to_json, :dealer_total => self.dealer_hand.total.to_json, :winner => "Push"}
    else
      { :player_total => self.player_hand.total.to_json, :player_cards => self.player_hand.to_json, :dealer_cards => self.dealer_hand.to_json, :dealer_total => self.dealer_hand.total.to_json, :winner => "Player"}
    end
  end

end