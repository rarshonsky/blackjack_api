require 'spec_helper'

describe Deck do

  before do
    @deck = Deck.new
  end

  describe "start" do
    it "should create the deck of cards" do
      @deck.start
      @deck.cards.first.value.should == 2
      @deck.cards.last.value.should == 1
    end
  end

  describe "shuffle" do
    it "should shuffle the deck" do
      @deck.start
      @deck.shuffle
      @deck.cards.first.value.should_not == 2
      @deck.cards.last.value.should_not == 1
    end
  end
  
  describe "next" do
    it "should return the next card in the deck" do
      @deck.start
      @deck.shuffle
      @next_card = @deck.cards.first
      @deck.next.should == @next_card
      @deck.cards.size.should == 51
    end
  end

end