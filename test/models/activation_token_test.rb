require 'test_helper'

class ActivationTokenTest < ActiveSupport::TestCase
  def setup
    @activation_token = ActivationToken.new(email: "user@example.com")
  end

  test "should be valid" do
    assert @activation_token.valid?
  end

  test "email should be present" do
    @activation_token.email = "    "
    assert_not @activation_token.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @activation_token.email = valid_address
      assert @activation_token.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@baz..com]
    invalid_addresses.each do |invalid_address|
      @activation_token.email = invalid_address
      assert_not @activation_token.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @activation_token.email = mixed_case_email
    @activation_token.save
    assert_equal mixed_case_email.downcase, @activation_token.reload.email
  end
end
