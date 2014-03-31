class Hand
  include Virtus.model

  attribute :cards
  attribute :stay

  def add_card(card)
    self.cards << card
  end

  def total
    total = 0
    self.cards.each do |c|
      total += c.value
    end

    aces = self.cards.select {|c| c.sym == 'a'}
    if aces.size > 0 && total < 12
      aces.first.value = 11
      total += 10
    elsif aces.size > 0 && total >21
      if aces.first.value == 11
        aces.first.value = 1
        total -= 10
      end
    end
    total
  end

  def bust?
    true if total > 21
  end

  def has_blackjack?
    if has_ace? && cards.size == 2
      self.cards.select do |c|
        return true if c.value == 10
      end
    end
    false
  end

  def has_ace?
    aces = self.cards.select {|c| c.sym == 'a'}
    if aces.size > 0
      return true
    end
    false
  end

end