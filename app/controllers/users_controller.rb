class UsersController < ApplicationController
  skip_before_action :ensure_signin, only: [:new, :create]

  def show
    @user = current_user
  end

  def new
    activation_token = ActivationToken.find(params[:id])
    if !activation_token.authenticated?(params[:token])
      redirect_to error_path
    end
    @user = User.new(email: activation_token.email)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      signin @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to profile_path
    else
      render 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      flash[:success] = 'Successfully profile updated!'
      redirect_to profile_path
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
