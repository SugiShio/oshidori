require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "signin with invalid information" do
    get signin_path
    assert_template 'sessions/new'
    post signin_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "signin with valid information" do
    get signin_path
    post signin_path, params: { session: { email: @user.email, password: 'password' } }
    assert_redirected_to profile_path
    follow_redirect!
    assert_template 'users/show'
    assert_select 'a[href=?]', signin_path, count: 0
    assert_select 'a[href=?]', signout_path
  end

  test "signout" do
    get signin_path
    delete signout_path
    assert_not is_signin?
    assert_redirected_to root_url
    follow_redirect!
    assert_template '/'
    assert_select 'a[href=?]', signin_path
    assert_select 'a[href=?]', signout_path, count: 0
  end
end
