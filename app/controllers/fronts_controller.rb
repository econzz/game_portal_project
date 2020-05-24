class FrontsController < ApplicationController
  def index

    @games = Game.all
    @categories = Category.all
  end

  def detail
    @categories = Category.all
    @game = Game.find(params[:id])

    @comments = Comment.where(game_id: params[:id])


    
  end

  def newcomment
    @comment = Comment.new(comments_params)
    @comment.game.game_id = params[:id]
    
    if @comment.save
      redirect_to detail_path(params[:id])
    else
      redirect_to detail_path(params[:id])
    end

    
  end

  def category
    @games = Game.where(category_id: params[:cid])
    @categories = Category.all
  end

  def play
    @game = Game.find(params[:id])
    @game.numberOfPlay += 1
    @game.save
  end

  def comments_params
    params.require(:comment).permit(:commenter,:content,:game_id)
  end
end
