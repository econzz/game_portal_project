class AdminsController < ApplicationController

  before_action :require_login, except: [:index]

  def index
    
  end

  def top

  end

  def require_login
    if session[:admin_id] == nil
      redirect_to admin_path, notice: "Please Login to proceed"
    end
  end
end
