require 'test_helper'

class ActivationTokenMailerTest < ActionMailer::TestCase
  def setup
    @activation_token = activation_tokens(:one)
  end

  test "create_account" do
    @activation_token.token = Token.new_token
    mail = ActivationTokenMailer.create_account(@activation_token)
    assert_equal "新規アカウント作成", mail.subject
    assert_equal [@activation_token.email], mail.to
    assert_equal ["norepry@oshidori.com"], mail.from
    assert_match CGI.escape(@activation_token.token), mail.body.encoded
  end
end
