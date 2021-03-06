ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def is_signin?
    !session[:user_id].nil?
  end

  # テストユーザーとしてログインする
  def signin_as(user)
    session[:user_id] = user.id
  end
end

class ActionDispatch::IntegrationTest
  # テストユーザーとしてログインする
  def signin_as(user, password: 'password', remember_me: '1')
    post signin_path, params: { session: { email: user.email, password: password, remember_me: remember_me } }
  end
end
