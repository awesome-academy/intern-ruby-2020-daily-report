class NewComment < ApplicationRecord
  belongs_to :user
  belongs_to :report

  scope :by_checked, ->(checked){where checked: checked}
  scope :by_user_id, (lambda do |user_id|
    where(user_id: user_id) if user_id.present?
  end)
  scope :by_report_id, (lambda do |report_id|
    where(report_id: report_id) if report_id.present?
  end)
end
