class ErrorsController < ApplicationController
  skip_before_action :ensure_signin

  def index
  end
end
