module Acme
  class GameAPI < Grape::API
    format :json

    desc 'Starts the game'
    get :game_api do
      game_id = cookies[:game_id]
      game = Rails.cache.read game_id
      if game_id == nil || game == nil
        game = Game.new
        game.start
        cookies[:game_id] = game.id
        Rails.cache.write game.id, game
      end
      game.data
    end

    desc 'Hits a card'
    params do
      requires :game_action, type: String, desc: "Game Action"
    end
    put :game_api do
      game_id = cookies[:game_id]
      game = Rails.cache.read(game_id)
      if game != nil
        action = params[:game_action]
        if action == 'hit'
          puts player_total: game.player_hand.total
          game.player_hit
          Rails.cache.write game.id, game
        elsif action == 'stay'
          game.dealer_plays
          Rails.cache.delete game.id
        end
        if game.game_over?
          Rails.cache.delete game.id
        end

        return game.data
      end
      {Error: 'No Game'}
    end

  end
end
