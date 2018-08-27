class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :ensure_signin

  def ensure_signin
    unless is_signin?
      flash[:warning] = 'This page requires singin.'
      redirect_to signin_path
    end
  end
end
