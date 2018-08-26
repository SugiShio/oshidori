module SessionsHelper
  def signin(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def is_signin?
    !session[:user_id].nil?
  end
end
