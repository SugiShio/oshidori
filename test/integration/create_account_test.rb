require 'test_helper'

class CreateAccountTest < ActionDispatch::IntegrationTest
  test "invalid information" do
    get new_create_account_path
    assert_no_difference 'ActivationToken.count' do
      post create_account_path, params: { activation_token: { email: "user@invalid" } }
    end
    assert_template 'activation_tokens/new'
  end

  test "valid information" do
    get new_create_account_path
    assert_difference 'ActivationToken.count', 1 do
      post create_account_path, params: { activation_token: { email: "valid@example.com" } }
    end
    mail = ActionMailer::Base.deliveries.last
    assert_equal "新規アカウント作成", mail.subject
    assert_equal ["valid@example.com"], mail.to
    follow_redirect!
    assert_template 'activation_tokens/show'
  end
end
