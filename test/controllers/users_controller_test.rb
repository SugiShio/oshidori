require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "should redirect show when not signin" do
    get profile_path
    assert_redirected_to signin_path
  end

  test "should redirect edit when not signin" do
    get edit_profile_path
    assert_redirected_to signin_path
    assert_not flash.empty?
  end

  test "should redirect update when not signin" do
    patch profile_path, params: { user: { name: @user.name, email: @user.email }}
    assert_redirected_to signin_path
    assert_not flash.empty?
  end
end
