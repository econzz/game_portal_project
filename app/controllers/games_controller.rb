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
    puts "================= START CREATE= "
    @game = Game.new(game_params)
    @game.cover_big = rails_blob_path(@game.cover_image, disposition: "attachment")
    @game.game_id = Time.now.to_f.to_s
    puts "================= >>>>= "+game_params[:game_zip].tempfile.to_s
    puts "================= NEW ID IS >>>>= "+@game.game_id

    unzipAndSaveToPublic(game_params[:game_zip].tempfile,@game.game_id)
    if @game.save
      puts "================= = END"
      #unzip
      flash[:notice] = "Game is successfully saved"
      redirect_to games_path(@game)
    else
      render 'new'
    end
    
  end

  def unzipAndSaveToPublic(tempZip,gameId)
    Zip::ZipFile.open(tempZip) { |zip_file|
        zip_file.each { |f|
          f_path=Rails.root.join('public/games/'+gameId, f.name)
          puts "================= = " + f_path.to_s
          FileUtils.mkdir_p(File.dirname(f_path))
          zip_file.extract(f, f_path) unless File.exist?(f_path)
        }
      }
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
    params.require(:game).permit(:name,:path,:description,:cover_image,:game_zip)
  end


  ####

  def require_login
    if session[:admin_id] == nil
      redirect_to admin_path, notice: "Please Login to proceed"
    end
  end
end
