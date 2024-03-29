class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    correct_user
    @admin = @user.admin
    @subs = Subscription.all
  end

  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params)
    @user.admin = false
    @user.subscription = "None"
    if @user.save
      flash[:success] = "Welcome to Simtek. Sign in to Start." 
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  def edit 
    @subscription = params[:subscription]
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Changes successful"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :admin,
                                 :subscription)
  end

  def logged_in_user
    unless user_logged_in?
      flash[:danger] = "Log in to edit profile"
      redirect_to root_path
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless @user == current_user
  end
end
