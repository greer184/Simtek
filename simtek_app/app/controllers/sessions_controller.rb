class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      redirect_to authenticate_path
    else
      flash.now[:danger] = 'Invalid email or password'
      render new
    end
  end

  def auth_page
    #made a class variable so that it persists instances
    @@code = rand.to_s[2..8]
    @user = current_user
    TwoFactorMailer.send_authentication_code(@user, @@code).deliver_now
  end

  def finish_login
    code = params[:session][:code]
    puts code
    if code && @@code == code
      @@code = ''
      flash[:success] = "Welcome to Simtek. Sign in to Start."
      redirect_to root_path
    else
      @@code = ''
      log_out
      flash.now[:danger] = 'Code was incorrect. Please log in again'
      redirect_to login_page_path
    end

  end

  def destroy

  end
end