class TopController < ApplicationController
  skip_before_action :ensure_signin

  def default
  end
end
