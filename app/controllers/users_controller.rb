class UsersController < ApplicationController
  def home
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    end
  end

  def login
  end

  def check
    @current_user = User.where(name: params[:name], password: params[:password]).first
    if @current_user
      session[:user_id] = @current_user.id
      flash[:info] = "Bienvenue #{@current_user.name} !"
      redirect_to "/users/home"
    else
      session[:user_id] = nil
      flash[:info] = "Échec de la connexion"
      redirect_to "/users/login"
    end
  end
end
