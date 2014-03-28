require 'spec_helper'

describe Hand do
  before do
    @hand = FactoryGirl.build(:hand)
    @ace = FactoryGirl.build(:ace)
    @jack = FactoryGirl.build(:jack)
    @seven = FactoryGirl.build(:seven)
  end

  after do
    @hand = FactoryGirl.build(:hand)
  end

  describe "total" do
    it 'should have a hard ace' do
      @hand.add_card @ace
      @hand.add_card @seven
      @hand.total.should == 18
    end

    it 'should have a soft ace' do
      #@hand.add_card @ace
      @hand.add_card @seven
      @hand.add_card @jack
      @hand.total.should == 18
    end




  end



end
