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
    @activation_token[:digest] = Token.digest(Token.new_token)
    if @activation_token.save
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
