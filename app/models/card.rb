class Card
  include Virtus.model

  attribute :suit, String
  attribute :value, Integer
  attribute :sym, String

  def to_json
    {:suit => self.suit, :value => self.value, :sym => self.sym}
  end
end