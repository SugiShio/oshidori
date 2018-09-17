class ActivationTokensController < ApplicationController
  skip_before_action :ensure_signin

  def show
    @activation_token = ActivationToken.find(params[:id])
  end

  def new
    @activation_token = ActivationToken.new
  end

  def create
    @activation_token = ActivationToken.new(activation_token_params)
    if User.find_by(email: @activation_token.email).present?
      flash[:success] = "すでに登録されているメールアドレスです"
      redirect_to signin_path
    elsif @activation_token.save
      ActivationTokenMailer.create_account(@activation_token).deliver_now
      redirect_to create_account_url(id: @activation_token.id)
    else
      render 'new'
    end
  end

  private

    def activation_token_params
      params.require(:activation_token).permit(:email)
    end
end
