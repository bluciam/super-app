class User < ActiveRecord::Base
  # A callback to endure that the email is saved in lowercase
  before_save { self.email = email.downcase }
  # A validation formula for the attribute name
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  # A validation formula for the attribute email, including following a format
  # and inforcing uniques (translated into an index in the database
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  # Ensures that the password is at least 6 characters
  validates :password, length: { minimum: 6 }
  # Presence validation for password and its confirmation are ensured by the
  # next line, which also requires that the two match by comparing encryptions,
  # as it add the authenticate method.
  has_secure_password
end
