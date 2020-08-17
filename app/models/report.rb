class Report < ApplicationRecord
  REPORTS_PARAMS = %i(today_plan actual reason_not_complete
    tomorrow_plan free_comment).freeze

  enum status: {waitting: 0, checked: 1}

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

  scope :recent_reports, ->{order created_at: :desc}
  scope :active_reports, ->{where deleted: false}
  scope :date_created, ->(date){where("date(created_at) = :date", date: date)}
  scope :status, ->(status){where("status = :status", status: status)}
end
