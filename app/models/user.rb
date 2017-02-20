class User < ActiveRecord::Base
  has_secure_password
  has_many :review

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  def self.authenticate_with_credentials(email, pword)
    logged_in_user = User.find_by(:email => email)
    if logged_in_user && logged_in_user.authenticate(pword)
      return logged_in_user
    else
      nil
    end
  end
end
