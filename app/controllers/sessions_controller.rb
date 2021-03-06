class SessionsController < ApplicationController
  skip_before_action :ensure_signin

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      signin @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_to profile_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    signout
    redirect_to root_path
  end
end

