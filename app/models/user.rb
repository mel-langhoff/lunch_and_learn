class User < ApplicationRecord

  validates :email, uniqueness: true, presence: true
  validates_presence_of :name, :password

  has_secure_password
  validates_confirmation_of :password

  before_create :generate_user_api_key

  private

  def generate_user_api_key
    # API keys are typically between 16 to 64 characters long
    self.api_key = SecureRandom.hex(16)
  end
end