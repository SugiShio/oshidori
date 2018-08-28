require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get new_user_path
    assert_no_difference 'User.count' do
      post user_path, params: { user: { name: "", email: "user@invalid", password: "foo", password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    assert flash.empty?
  end

  test "valid signup information" do
    get new_user_path
    assert_difference 'User.count', 1 do
      post user_path, params: { user: { name: "Example User", email: "valid@example.com", password: "password", password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash[:success].blank?
  end
end
