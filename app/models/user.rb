class User < ApplicationRecord
  include Token
  attr_accessor :remember_token
  before_save { email.downcase! }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = Token.new_token
    update_attribute(:remember_digest, Token.digest(remember_token))
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end


    def set_email(id)
      activation_token = ActivationToken.find(id)
      self.email ||= activation_token.email
    end
end
