class UsersController < ApplicationController
  def index
    if @current_user.try(:role) != "admin"
      flash[:error] = "Accès interdit"
      return redirect_to request.referrer || users_home_path
    else
      @users = User.all
    end
  end
  
  def home
  end

  def login
  end
  
  def logout
    session[:user_id] = nil
    flash[:info] = "Vous êtes maintenant déconnecté."
    redirect_to users_home_path
  end

  def check
    @current_user = User.where(name: params[:name], password: params[:password]).first
    if @current_user
      session[:user_id] = @current_user.id
      flash[:info] = "Bienvenue #{@current_user.name} !"
      redirect_to users_home_path
    else
      session[:user_id] = nil
      flash[:info] = "Échec de la connexion"
      redirect_to users_login_path
    end
  end
end
