class User < ApplicationRecord
  has_secure_password
  before_save{email.downcase!}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :name, presence: true,
    length: {maximum: Settings.validation.name_max}
  validates :email, presence: true,
    length: {maximum: Settings.validation.email_max},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: true

  def User.digest string
    cost = if ActiveModel::SecurePassword.min_cost
    BCrypt::Engine::MIN_COST
  else
    BCrypt::Engine.cost
  end
    BCrypt::Password.create
  end
end
