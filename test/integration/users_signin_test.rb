require 'test_helper'

class UsersSigninTest < ActionDispatch::IntegrationTest
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
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select 'a[href=?]', signin_path, count: 0
    assert_select 'a[href=?]', signout_path
  end

  test "signout" do
    get signin_path
    signin_as(@user)
    delete signout_path
    assert_not is_signin?
    assert_redirected_to root_url
    follow_redirect!
    assert_template '/'
    assert_select 'a[href=?]', signin_path
    assert_select 'a[href=?]', signout_path, count: 0
  end

  test "signin with remembering" do
    signin_as(@user, remember_me: '1')
    assert_not_empty cookies['remember_token']
  end

  test "signin without remembering" do
    # クッキーを保存してログイン
    signin_as(@user, remember_me: '1')
    delete signout_path
    # クッキーを削除してログイン
    signin_as(@user, remember_me: '0')
    assert_empty cookies['remember_token']
  end
end
