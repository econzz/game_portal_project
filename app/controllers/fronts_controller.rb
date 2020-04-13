class FrontsController < ApplicationController
  def index
    @games = Game.all
    
  end

  def detail

  end
end
