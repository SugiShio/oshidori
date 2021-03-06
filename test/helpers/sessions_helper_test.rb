require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @user = users(:michael)
    remember(@user)
  end

  test "current_user returns right user when session is nil" do
    assert_equal @user, current_user
    assert is_signin?
  end

  test "current_user returns nil when remember digest is wrong" do
    @user.update_attribute(:remember_digest, Token.digest(Token.new_token))
    assert_nil current_user
  end
end
