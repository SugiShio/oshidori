class SessionsController < ApplicationController
  skip_before_action :ensure_signin

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      signin user
      redirect_to user
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

