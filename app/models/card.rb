class Card
  include Virtus.model

  attribute :suit, String
  attribute :value, Integer
  attribute :sym, String

end