class ActivationTokenMailer < ApplicationMailer
  def create_account(activation_token)
    @activation_token = activation_token
    mail to: activation_token.email, subject: '新規アカウント作成'
  end
end
