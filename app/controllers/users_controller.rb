class UsersController < ApplicationController
  skip_before_action :ensure_signin, only: [:new, :create]

  def show
    @user = current_user
  end

  def new
    @activation_token = ActivationToken.find(params[:id])
    @token = params[:token]
    if !@activation_token.authenticated?(@token)
      redirect_to error_path
    end
    @user = User.new
  end

  def create
    @activation_token = ActivationToken.find(params[:token_id])
    @token = params[:token]
    if @activation_token.authenticated?(@token)
      @user = User.new(user_params)
      @user.set_email(@activation_token.id)
      if @user.save
        signin @user
        flash[:success] = "Welcome to the Sample App!"
        redirect_to profile_path
      else
        render 'new'
      end
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
      params.require(:user).permit(:name, :password, :password_confirmation)
    end
end
