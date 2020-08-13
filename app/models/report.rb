class Report < ApplicationRecord
  REPORTS_PARAMS = %i(today_plan actual reason_not_complete
    tomorrow_plan free_comment).freeze

  enum status: {waiting: 0, checked: 1}

  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :today_plan, presence: true,
    length: {maximum: Settings.validates.report.max_length}
  validates :actual, presence: true,
    length: {maximum: Settings.validates.report.max_length}
  validates :tomorrow_plan, presence: true,
    length: {maximum: Settings.validates.report.max_length}
  validates :reason_not_complete,
            length: {maximum: Settings.validates.report.max_length}
  validates :free_comment,
            length: {maximum: Settings.validates.report.max_length}

  delegate :name, :email, to: :user, prefix: true

  scope :recent_reports, ->{order created_at: :desc}
  scope :active_reports, ->{where deleted: false}
  scope :by_ids, ->(report_ids){where id: report_ids}
  scope :by_users, ->(user_ids){where user_id: user_ids}
  scope :by_date_created, (lambda do |date|
    where("date(created_at) = :date", date: date) if date.present?
  end)
  scope :by_status, (lambda do |status|
    where(status: status) if status.present?
  end)
end
