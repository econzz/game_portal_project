class CommentsController < ApplicationController
  def create
    @game = Game.find(params[:id])

    
  end

  def update
  end

  def delete
  end
end
