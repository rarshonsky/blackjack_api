module Acme
  class Start < Grape::API
    format :json
    desc 'Starts the game'
    params do
      requires :game_id, type: Integer, desc: "Game ID"
    end
    get :start do
      puts test: params[:game_id]
      game = Rails.cache.read(params[:game_id])
      if game != nil
        puts player_total: game.player_hand.total
        return game.data
      end
      {Error: 'No Game'}
    end

    desc 'Starts the game'
    post :start do
        game = Game.new
        game.start
        Rails.cache.write game.id, game
        { game_id: game.id, cards: game.player_hand, dealer_card: game.dealer_hand.cards.first}
    end

    desc 'Hits a card'
    params do
      requires :game_id, type: Integer, desc: "Game ID"
    end
    put :start do
      game = Rails.cache.read(params[:game_id])
      if game != nil
        puts player_total: game.player_hand.total
        busted = game.player_hit
        if busted
          Rails.cache.delete game.id
          return game.data
        end
        Rails.cache.write game.id, game
        return game.data
      end
      {Error: 'No Game'}
    end

    desc 'Stays'
    params do
      requires :game_id, type: Integer, desc: "Game ID"
    end
    delete :start do
      game = Rails.cache.read(params[:game_id])
      if game != nil
        game.dealer_plays
        Rails.cache.write game.id, game
        return game.data
      end
      {Error: 'No Game'}
    end


  end
end
