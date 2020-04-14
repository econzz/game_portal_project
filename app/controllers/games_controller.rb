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
    
       
      Zip::ZipFile.open(game_params[:game_zip].tempfile) { |zip_file|
        zip_file.each { |f|
          f_path=Rails.root.join('public/'+game_params[:game_zip].original_filename, f.name)
          puts "================= = " + f_path.to_s
          FileUtils.mkdir_p(File.dirname(f_path))
          zip_file.extract(f, f_path) unless File.exist?(f_path)
        }
      }
      
  
    
    if @game.save
      puts "================= = END"
      #unzip
      flash[:notice] = "Game is successfully saved"
      redirect_to games_path(@game)
    else
      render 'new'
    end
    
  end

  # def unzip
  #   zipfile = params[:zip_file]
  #     Zip::File.open(rails_blob_path(@game.game_zip, disposition: "attachment")) do |zip|
  #       zip.each do |entry|
  #         ext = File.extname(entry.name)
  #         # 隠しファイルやゴミファイルは無視
  #         next if ext.blank? || File.basename(entry.name).count(".") > 1
  #         # テンポラリファイルを開く
  #         Tempfile.open([File.basename(entry.to_s), ext]) do |file|
  #           begin
  #             # 一時ファイルを作成
  #             entry.extract(file.path) { true }
  #             # モデルを作成
  #             image = Image.create!(source: file)
  #           ensure
  #             # 終わったらclose
  #             file.close!
  #         end
  #       end
  #     end
  #   end
  # end

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
