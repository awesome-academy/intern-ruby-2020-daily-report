class Comment < ApplicationRecord
  COMMENT_PARAMS = %i(content report_id).freeze

  belongs_to :report
  belongs_to :user

  validates :content, presence: true,
    length: {maximum: Settings.validates.comment.max_length}

  delegate :name, :avatar, to: :user, prefix: true

  scope :includes_user, ->{includes :user}
  scope :order_by_created_at, ->{order created_at: :desc}
  scope :by_report_id, ->(report_id){where(report_id: report_id)}
end
