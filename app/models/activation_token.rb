class ActivationToken < ApplicationRecord
  include Token
  attr_accessor :token
  before_save :downcase_email, :create_token
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

  private

    def create_token
      self.token = Token.new_token
      self.digest = Token.digest(token)
    end

    # メールアドレスをすべて小文字にする
    def downcase_email
      self.email = email.downcase
    end
end
