require 'spec_helper'

describe Acme::GameAPI do

  it 'should start game and have 2 player cards and 1 dealer card' do
    get '/api/game_api'
    game_data = JSON.parse(response.body)
    game_data['player_cards']['cards'].size.should == 2
    game_data['dealer_cards']['cards'].size.should == 1
  end

  it 'should hit and have 3 player cards' do
    get '/api/game_api'
    request.cookies['game_id'] = response.cookies['game_id']
    put '/api/game_api', {:game_action => "hit"}
    game_data = JSON.parse(response.body)
    game_data['player_cards']['cards'].size.should == 3
  end

  it 'should stay and the dealer should show more than 1 card as well as winner should be declared' do
    get '/api/game_api'
    request.cookies['game_id'] = response.cookies['game_id']
    put '/api/game_api', {:game_action => "stay"}
    game_data = JSON.parse(response.body)
    game_data['player_cards']['cards'].size.should == 2
    game_data['dealer_cards']['cards'].size.should > 1
    game_data['winner'].should_not == nil
  end

end
