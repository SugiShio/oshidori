require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    @activation_token = activation_tokens(:one)
  end

  test "signup with invalid token" do
    get signup_path, params: { token_id: @activation_token.id, token: 'invalid_token' }
    follow_redirect!
    assert_template 'errors/show'
  end

  test "invalid signup information" do
    get signup_path, params: { token_id: @activation_token.id, token: 'test_token' }
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name: "", password: "foo", password_confirmation: "bar" }, token_id: @activation_token.id, token: 'test_token' }
    end
    assert_template 'users/new'
  end

  test "valid signup information" do
    get signup_path, params: { token_id: @activation_token.id, token: 'test_token' }
    assert_difference 'User.count', 1 do
      post signup_path, params: { user: { name: "Example User", password: "password", password_confirmation: "password" }, token_id: @activation_token.id, token: 'test_token' }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash[:success].blank?
  end
end
