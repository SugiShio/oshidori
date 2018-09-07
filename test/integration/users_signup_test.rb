require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    @activation_token = activation_tokens(:one)
  end

  test "invalid signup information" do
    get signup_path, params: { id: @activation_token.id, token: 'test_token' }
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name: "", email: "user@invalid", password: "foo", password_confirmation: "bar" } }
    end
    assert_template 'users/new'
  end

  test "valid signup information" do
    get signup_path, params: { id: @activation_token.id, token: 'test_token' }
    assert_difference 'User.count', 1 do
      post signup_path, params: { user: { name: "Example User", email: "valid@example.com", password: "password", password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash[:success].blank?
  end
end
