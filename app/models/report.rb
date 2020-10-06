class Report < ApplicationRecord
  REPORTS_PARAMS = %i(today_plan actual reason_not_complete
    tomorrow_plan free_comment).freeze

  enum status: {waiting: 0, checked: 1, rejected: 2}

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :new_comments, dependent: :destroy

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

  ransacker :created_at, type: :date do
    Arel.sql("date(reports.created_at)")
  end

  scope :includes_user, ->{includes :user}
  scope :recent_reports, ->{order created_at: :desc}
  scope :active_reports, ->{where deleted: false}
  scope :by_ids, ->(report_ids){where id: report_ids}
  scope :by_users, ->(user_ids){where user_id: user_ids}
  scope :by_date_created, (lambda do |date|
    where("date(created_at) = :date", date: date) if date.present?
  end)
  scope :order_by_created, (lambda do |type_order|
    type_order = type_order.presence || :desc
    order created_at: type_order
  end)
  scope :order_by_status, (lambda do |type_order|
    type_order = type_order.presence || :asc
    order status: type_order
  end)
end
