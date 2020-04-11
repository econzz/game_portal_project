class GamesController < ApplicationController
  before_action :require_login, :set_game, only: [:edit,:update, :show, :destroy]
  def index
      @games = Game.all
  end

  def new
    @game = Game.new(:numberOfPlay => 0, :cover_big=>"",:preview_big=>"",:category=>1,)
  end

  def create
    #render plain: params[:game].inspect

    @game = Game.new(game_params)
    if @game.save
      flash[:notice] = "Game is successfully saved"
      redirect_to games_path(@game)
    else
      render 'new'
    end
    
  end

  ####
  def edit
    @game = Game.find(params[:id])


    
  end

  def update
    @game = Game.find(params[:id])


    if @game.update(game_params)
      flash[:notice] = "Game is successfully updated"
      redirect_to games_path(@game)
    else
      render 'edit'
    end
  end

  ####games/<id> show after register
  
  def show
    @game = Game.find(params[:id])
  end
  
  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    flash[:notice] = "game was successfully deleted"
    redirect_to games_path
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:name,:path,:description)
  end


  ####

  def require_login
    if session[:admin_id] == nil
      redirect_to admin_path, notice: "Please Login to proceed"
    end
  end
end
