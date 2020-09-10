class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  USERS_PARAMS = %i(name email password password_confirmation avatar).freeze
  PASSWORD_REGEX = Settings.validates.password.regex

  enum role: {member: 0, manager: 1, admin: 2}

  belongs_to :division, optional: true
  has_many :reports, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_one_attached :avatar

  validates :name, presence: true,
    length: {maximum: Settings.validates.user.max_length_name}
  validates :email, presence: true,
    length: {maximum: Settings.validates.user.max_length_email},
    format: {with: Settings.validates.user.validate_email_regex},
    uniqueness: {case_sensitive: true}
  validates :password, presence: true,
    length: {minimum: Settings.validates.user.min_length_password},
    allow_nil: true
  validates :avatar,
            content_type: {in: Settings.validates.user.avatar_type.split,
                           message: I18n.t("users.avatar_type_validate")}
  validate :password_complexity

  delegate :division_name, to: :division

  before_save :downcase_email

  scope :includes_division, ->{includes :division}
  scope :by_division_id, (lambda do |division_id|
    where(division_id: division_id)
  end)
  scope :like_email, (lambda do |email|
    where("email like :email", email: "%#{email}%") if email.present?
  end)
  scope :like_name, (lambda do |name|
    where("name like :name", name: "%#{name}%") if name.present?
  end)

  class << self
    def from_omniauth auth
      user = User.find_by email: auth.info.email
      return user if user

      omniauth_user auth
    end

    def omniauth_user auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
        user.name = auth.info.name
        user.image = auth.info.image
        user.uid = auth.uid
        user.provider = auth.provider
        user.skip_confirmation!
      end
    end
  end

  private

  def downcase_email
    email.downcase!
  end

  def password_complexity
    return unless password.present? && !password.match(PASSWORD_REGEX)

    errors.add :password, I18n.t("validates.password.error_regex")
  end
end
