class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by username: params[:login][:username]
    if user && user.authenticate(params[:login][:password])
      session[:user_id] = user.id
      redirect_to reservations_path
    else
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end

