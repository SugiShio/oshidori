# Preview all emails at http://localhost:3000/rails/mailers/activation_token_mailer
class ActivationTokenMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/activation_token_mailer/create_account
  def create_account
    activation_token = ActivationToken.last
    activation_token.token = Token.new_token
    ActivationTokenMailer.create_account(activation_token)
  end

end
