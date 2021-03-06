require 'spec_helper'

describe Game do

  before do
    @game = Game.new
  end

  describe "start" do
    it "should have busted" do
      @game.start
      @game.player_hand.cards.size.should == 2
      @game.dealer_hand.cards.size.should == 2
      @game.deck.should_not == nil
      @game.id == nil
    end
  end

  describe "player_hit"  do
    before do
      @game.start
    end
    it "should add a card to the players hand" do
      @game.player_hit
      @game.player_hand.cards.size.should == 3
    end
  end

  describe "dealer_hit"  do
    before do
      @game.start
    end
    it "should add a card to the players hand" do
      @game.dealer_hit
      @game.dealer_hand.cards.size.should == 3
    end
  end

  describe "dealer_plays" do
    before do
      @game.start
    end
    it "should play until there is a winner" do
      @game.dealer_plays
      @game.data.to_json.include?('winner').should == true
    end
  end

  describe "game_over?" do
    before do
      @game.start
      @ace = FactoryGirl.build(:ace)
      @king = FactoryGirl.build(:king)
      @game.player_hand.cards.clear
      @game.player_hand.add_card @ace
      @game.player_hand.add_card @king
    end

    it "should be game over" do
      @game.game_over?.should == true
    end
  end

end