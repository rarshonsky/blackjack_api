require 'card'

class Deck
  include Virtus.model

  SUITS = %w(C D H S).freeze
  SYMS_VALS = {2 => 2, 3 => 3, 4 => 4, 5 => 5, 6 => 6, 7 => 7, 8 => 8, 9 => 9, 10 => 10, :j => 10, :q => 10, :k => 10, :a  => 1}.freeze


  attribute :cards

  def start(number_of_decks=1)
    self.cards ||= []
    (0..number_of_decks).each do |i|
      SUITS.each do |suit|
        SYMS_VALS.keys.each do |sym|
          self.cards << Card.new(suit: suit, sym: sym, value: SYMS_VALS[sym])
        end
      end
    end
  end

  def shuffle
    self.cards.shuffle!
  end

  def next
    self.cards.shift
  end

end