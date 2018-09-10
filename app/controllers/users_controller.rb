class UsersController < ApplicationController
  before_action :ensure_signout, only: [:new, :create]
  skip_before_action :ensure_signin, only: [:new, :create]

  def show
    @user = current_user
  end

  def new
    if params[:id].nil? || params[:token].nil?
      redirect_to error_path and return
    end
    @activation_token = ActivationToken.find(params[:id])
    @token = params[:token]
    if !@activation_token.authenticated?(@token)
      redirect_to error_path
    elsif User.find_by(email: @activation_token.email).present?
      flash[:success] = "すでに登録されているメールアドレスです"
      redirect_to signin_path
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
      redirect_to error_path
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

    def ensure_signout
      if is_signin?
        flash[:success] = "すでにログインしています"
        redirect_to profile_path
      end
    end
end
