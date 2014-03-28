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
    puts aces: aces
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

end