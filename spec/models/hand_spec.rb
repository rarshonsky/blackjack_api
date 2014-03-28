require 'spec_helper'

describe Hand do

  let(:jack) { Card.new(suit:'D',value: 10, sym: 'j')}
  let(:seven) { Card.new(suit:'D',value: 7, sym: '7')}
  let(:ace) { Card.new(suit:'C',value: 11, sym: 'a')}
  let(:hand) {  build(:hand) }

  describe "total no ace" do
    hand = Hand.new cards: []
    jack = Card.new(suit:'D',value: 10, sym: 'j')
    seven = Card.new(suit:'D',value: 7, sym: '7')
    hand.add_card jack
    hand.add_card seven
    hand.total.should == 17

  end



end
