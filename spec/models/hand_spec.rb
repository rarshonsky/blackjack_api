require 'spec_helper'

describe Hand do

  describe "total" do

    before do
      @hand = FactoryGirl.build(:hand)
      @ace = FactoryGirl.build(:ace)
      @jack = FactoryGirl.build(:jack)
      @seven = FactoryGirl.build(:seven)
    end

    after do
      @hand = FactoryGirl.build(:hand)
    end

    it 'should have a soft ace' do
      @hand.add_card @ace
      @hand.add_card @seven
      @hand.total.should == 18
    end

    it 'should have 2 hard aces' do
      @hand.cards = []
      @hand.add_card @seven
      @hand.add_card @ace
      @hand.add_card @jack
      @hand.add_card @ace
      @hand.total.should == 19
    end

    it 'should have 1 soft ace and 2 hard aces' do
      @hand.cards = []
      @hand.add_card @ace
      @hand.add_card @ace
      @hand.add_card @ace
      @hand.total.should == 13
    end

    it 'should have a soft ace' do
      @hand.cards = []
      @hand.add_card @ace
      @hand.add_card @jack
      @hand.add_card @jack
      @hand.total.should == 21
    end

    it 'should have a soft ace and a hard ace' do
      @hand.cards = []
      @hand.add_card @ace
      @hand.add_card @jack
      @hand.add_card @ace
      @hand.total.should == 12
    end

  end

  describe "has_blackjack?" do
    before do
      @hand = FactoryGirl.build(:hand)
      @ace = FactoryGirl.build(:ace)
      @king = FactoryGirl.build(:king)
      @seven = FactoryGirl.build(:seven)
    end

    it "should have a blackjack" do
      @hand.cards = []
      @hand.add_card @ace
      @hand.add_card @king
      @hand.has_blackjack?.should == true
    end

    it "should not have a blackjack" do
      @hand.cards = []
      @hand.add_card @seven
      @hand.add_card @king
      @hand.has_blackjack?.should == false
    end

    it "should not have a blackjack" do
      @hand.cards = []
      @hand.add_card @seven
      @hand.add_card @king
      @hand.add_card @ace
      @hand.add_card @ace
      @hand.add_card @ace
      @hand.add_card @ace
      @hand.has_blackjack?.should == false
    end

  end

  describe "has_ace?" do
    before do
      @hand = FactoryGirl.build(:hand)
      @ace = FactoryGirl.build(:ace)
      @king = FactoryGirl.build(:king)
      @seven = FactoryGirl.build(:seven)
    end

    it "should have an ace" do
      @hand.cards = []
      @hand.add_card @ace
      @hand.add_card @king
      @hand.has_ace?.should == true
    end

    it "should not have an ace" do
      @hand.cards = []
      @hand.add_card @king
      @hand.add_card @king
      @hand.has_ace?.should == false
    end

  end

  describe "busted?" do
    before do
      @hand = FactoryGirl.build(:hand)
      @ace = FactoryGirl.build(:ace)
      @king = FactoryGirl.build(:king)
      @seven = FactoryGirl.build(:seven)
    end

    it "should have busted" do
      @hand.cards = []
      @hand.add_card @king
      @hand.add_card @king
      @hand.add_card @seven
      @hand.bust? == true
    end

    it "should not have busted" do
      @hand.cards = []
      @hand.add_card @king
      @hand.add_card @king
      @hand.bust? == true
    end

  end

end
