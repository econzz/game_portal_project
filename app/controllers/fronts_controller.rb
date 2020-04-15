class FrontsController < ApplicationController
  def index
    @games = Game.all
    
  end

  def detail
    @game = Game.find(params[:id])
  end

  def play
    @game = Game.find(params[:id])
  end
end
