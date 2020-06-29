module Api
  module V1
    class PinterfacesController < ApplicationController
      
      def ranking_total
        gameid = params[:game_id]
        page = params[:page]

        @game = Game.find_by(game_id: gameid)
        @ranking = Ranking.find_by(game_id: @game.id)

        render json:{status:"SUCCESS",message:"PLAYER SUCCESS LOADING "+gameid+" gameid "+@game.id.to_s}
      end

     
      def register_score

        gameid = params[:game_id]
        playerid = params[:player_id]
        playername = params[:player_name]

        @player = Game.find_by(hash_id: playerid)

        

        @game = Game.find(params[:game_id])

        @ranking = Ranking.find_by(game_id: @game.id)

        
        render json:{status:"SUCCESS",message:"ranking SUCCESS LOADING "+@game.id}
      end
    end
  end
end
