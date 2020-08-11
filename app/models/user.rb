class User < ApplicationRecord
  USERS_PARAMS = %i(name email password password_confirmation).freeze

  belongs_to :division, optional: true
  has_many :reports, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :name, presence: true,
    length: {maximum: Settings.validates.user.max_length_name}
  validates :email, presence: true,
    length: {maximum: Settings.validates.user.max_length_email},
    format: {with: Settings.validates.user.validate_email_regex},
    uniqueness: {case_sensitive: true}
  validates :password, presence: true,
    length: {minimum: Settings.validates.user.min_length_password}

  has_secure_password

  before_save :downcase_email

  private

  def downcase_email
    email.downcase!
  end
end
