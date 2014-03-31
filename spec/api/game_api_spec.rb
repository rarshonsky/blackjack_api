require 'spec_helper'

describe Acme::GameAPI do
  it 'should start game' do
    get '/api/game'
    response.body.should == { ping: 'pong' }.to_json
  end

end
