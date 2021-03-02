class User < ApplicationRecord

  # == Extensions ===========================================================

  has_secure_password
  
  # == Relationships ========================================================

  has_many :messages
  has_many :user_channels
  has_many :channels, through: :user_channels
  
  # == Validations ==========================================================

  validates :username, 
    presence: true,
    length: {minimum: 2, maximum: 40}, uniqueness: true

  validates :email, 
    email: true,
    uniqueness: true,
    length: { minimum: 2, maximum: 254 },
    presence: true

  validates :password, 
    confirmation: true,
    length: {minimum: 4}

  validates_presence_of :password_confirmation
  validates_presence_of :password_digest
end
