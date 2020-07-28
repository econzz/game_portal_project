module Api
  module V1
    class PinterfacesController < ApplicationController
      protect_from_forgery unless: -> { request.format.json? }

      #/v1/<game_id>/ranking_total/<page>
      def ranking_total
        gameid = params[:game_id]
        page = params[:page]

        dataPerPage = 100
        offset = 0

        if(page.to_i > 1)
          offset = dataPerPage * page
        end
        @game = Game.find_by(game_id: gameid)
        @ranking = @game.rankings.limit(dataPerPage).offset(offset).order(score: :desc) 
        ranksArray = []
        rank = 1
        for i in @ranking do
          tempData = {
            rank:rank,
            player:{
              id:i.player.id,
              name:i.player.name
            },
            score:i.score
          };
          ranksArray.push tempData
          rank += 1
        end

        render json:{
          now_page:1,
          page_count:1,
          updated_at:"",
          ranks:ranksArray
        }
      end

      #/v1/<game_id>/add_score
      def addition_score
        gameid = params[:game_id]
        playerId = params[:player_id]
        playerName = params[:player_name]
        score = params[:score]

        @player = process_save_player(playerId,playerName)

        @game = Game.find_by(game_id: gameid)

        
        

        if(@player != nil)
          puts "ranking is1"
          puts @game.rankings
          @ranking = @game.rankings.find_by(players_id:@player.id)
          scoreToSave = @ranking.score + score

          if process_save_score(@game,@player,scoreToSave)
            render json:{status:"ok"}
          else
            render json:{errno:803,message:"Ranking Error"}
          end
        else
          render json:{errno:802,message:"Player Error"}
        end


      end
      
      #/v1/<game_id>/register_score
      def register_score

        gameid = params[:game_id]
        playerId = params[:player_id]
        playerName = params[:player_name]
        score = params[:score]
        @game = Game.find_by(game_id: gameid)
        @player = process_save_player(playerId,playerName)

        if(@player != nil)
          if process_save_score(@game,@player,score)
            render json:{status:"ok"}
          else
            render json:{errno:803,message:"Ranking Error"}
          end
        else
          render json:{errno:802,message:"Player Error"}
        end

      end

      

      #/v1/player/<playerID> GET
      def retrieve_player
        playerid = params[:player_id]
        
        @player = Player.find_by(hash_id: playerid)
        if(@player != nil)
          render json:{player:{id:@player.hash_id,name:@player.name}}
        else
          render json:{errno:802,message:"Player Error"}
        end

      end

      #/v1/player/<playerID> POST
      def register_player
        playerId = params[:player_id]
        playerName = params[:player_name]

        @player = process_save_player(playerId,playerName)

        if(@player != nil)
          render json:{player:{id:@player.hash_id,name:@player.name}}
        else
          render json:{errno:802,message:"Player Error"}
        end

      end


      
      def process_save_score(game,player,score)
        
        @ranking = game.rankings.find_by(players_id:player.id)
          
        if(@ranking != nil)

          if @ranking.score < score
            if @ranking.update(score: score)
              return true
            else
              return false
            end
          else
            return true
            
          end
        else
          @newranking = Ranking.new(game_id: game.id, players_id: player.id)
          @newranking.score = score
          if @newranking.save
            return true
          else
            return false
          end
        end

      end

      def process_save_player(playerHashId,playerName)
        @player = Player.find_by(hash_id: playerHashId)
        
        if(@player == nil)
          puts  "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
          puts  "EMPTY PLAYER"
          puts  "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
          puts  ""+@player.inspect
          @newplayer = Player.new(hash_id: playerHashId, name: playerName)
          if @newplayer.save
            puts  "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
            puts  "NEW PLAYER"
            puts  "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
            puts  @newplayer.inspect
            return @newplayer
          else
            puts  "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
            puts  "ERROR player"
            return nil
          end
        else
          
          if @player.update(name: playerName)
            puts  "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
            puts  "UPDATED player"
            puts  "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
            puts  @player.inspect
            return @player
          else
            return nil
          end
        end
      end


    end
  end
end
