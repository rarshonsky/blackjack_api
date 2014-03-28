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
    self.id = 1
    self.player_hand = Hand.new({cards: [self.deck.next], stay:false})
    self.dealer_hand = Hand.new({cards: [self.deck.next]})
    player_hit
    dealer_hit

  end

  def player_hit
    self.player_hand.add_card self.deck.next
    self.player_hand.bust?
  end

  def dealer_hit
    self.dealer_hand.add_card self.deck.next
    self.dealer_hand.bust?
  end

  def dealer_plays
    self.player_hand.stay = true
    player_total = self.player_hand.total
    while self.dealer_hand.total < player_total && self.dealer_hand.total <17
      self.dealer_hit
    end
  end

  def data
    self.player_hand.total
    self.dealer_hand.total

    if self.player_hand.bust?
      return { game_id: self.id, cards: self.player_hand, dealer_cards: self.dealer_hand, player_total: self.player_hand.total, dealer_total: self.dealer_hand.total, winner: 'Dealer'}
    elsif self.dealer_hand.bust?
      return { game_id: self.id, cards: self.player_hand, dealer_card: self.dealer_hand, player_total: self.player_hand.total, dealer_total: self.dealer_hand.total, winner: 'Player'}
    elsif !self.player_hand.stay
      return { game_id: self.id, cards: self.player_hand, dealer_cards: self.dealer_hand.cards.first}
    elsif self.dealer_hand.total > self.player_hand.total
      return { game_id: self.id, cards: self.player_hand, dealer_card: self.dealer_hand, player_total: self.player_hand.total, dealer_total: self.dealer_hand.total, winner: 'Dealer'}
    elsif self.dealer_hand.total == self.player_hand.total
      return { game_id: self.id, cards: self.player_hand, dealer_card: self.dealer_hand, player_total: self.player_hand.total, dealer_total: self.dealer_hand.total, winner: 'Push'}
    else
      return { game_id: self.id, cards: self.player_hand, dealer_card: self.dealer_hand, player_total: self.player_hand.total, dealer_total: self.dealer_hand.total, winner: 'Player'}
    end
  end

end