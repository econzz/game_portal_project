class SessionsController < ApplicationController
  def new
  end

  def create
    admin = Admin.find_by_email(params[:email])
    if admin && admin.authenticate(params[:password])
      if params[:remember_me]
        cookies.signed[:user_id] = { value: admin.id, expires: 2.weeks.from_now }
      end
      session[:admin_id] = admin.id
      session[:admin_email] = admin.email
      redirect_to games_path, notice: "Logged in!"
    else
      redirect_to admin_path, notice: "Email or password is invalid"
    end
  end

  def destroy
    session[:admin_id] = nil
    session[:admin_email] = nil
    cookies.delete :user_id
    redirect_to admin_path, notice: "Logged out!"
  end

end
