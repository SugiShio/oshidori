require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    signin_as(@user)
    get edit_user_path
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "", email: "invalid@example" } }
    assert_template 'users/edit'
  end

  test "successful edit" do
    signin_as(@user)
    get edit_user_path
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name: name, email: email} }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
