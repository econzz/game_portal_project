class GamesController < ApplicationController
  before_action :require_login
  before_action :set_game, only: [:edit,:update, :show, :destroy]
  def index
      @games = Game.all
  end

  def new
    @game = Game.new(:numberOfPlay => 0)
    @categories = Category.all
  end

  def create
    @categories = Category.all
    @game = Game.new(game_params)

    @game.category = Category.find(params[:category_id])
    @game.game_id = Time.now.to_f.to_s.gsub(".", "")

    if game_params[:game_zip]
      unzipAndSaveToPublic(game_params[:game_zip].tempfile,@game.game_id)
    end

    if game_params[:cover_image_big]
      @game.cover_big = rails_blob_path(@game.cover_image_big, disposition: "attachment")
    end
    
    
    if @game.save
      flash[:notice] = "Game is successfully saved"
      redirect_to games_path(@game)
    else
      render 'new'
    end
    
  end

  ####
  def edit
    @categories = Category.all

    @game = Game.find(params[:id])
    

    
  end

  def update
    @categories = Category.all

    

    @game = Game.find(params[:id])
    @game.category = Category.find(params[:category_id])

    if game_params[:game_zip]
      path=Rails.root + 'public/games/'+@game.game_id
      delete_directory(path)
      unzipAndSaveToPublic(game_params[:game_zip].tempfile,@game.game_id)
    end

    if game_params[:cover_image_big]
      @game.cover_big = rails_blob_path(@game.cover_image_big, disposition: "attachment")
    end
    
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
    path=Rails.root + 'public/games/'+@game.game_id
    delete_directory(path)
    @game.destroy
    flash[:notice] = "game was successfully deleted"
    redirect_to games_path
  end

  private
  def unzipAndSaveToPublic(tempZip,gameId)
    Zip::ZipFile.open(tempZip) { |zip_file|
        zip_file.each { |f|
          f_path=Rails.root.join('public/games/'+gameId, f.name)
          FileUtils.mkdir_p(File.dirname(f_path))
          zip_file.extract(f, f_path) unless File.exist?(f_path)
        }
      }
  end

  private
  def delete_directory(path)
    if File.directory?(path)
      if !Dir.empty?(path)
        Pathname.new(path).children.each { |p| p.rmtree }
      end
    end
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:name,:path,:description,:cover_image,:cover_image_big,:icon_image,:game_zip)
  end


  ####

  def require_login
    if session[:admin_id] == nil
       redirect_to admin_path, notice: "Please Login to proceed"
    else
      puts "-------------- isloggedin" 
      puts session[:admin_email]
      
    end
  end
end
