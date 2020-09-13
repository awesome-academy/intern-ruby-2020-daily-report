class Comment < ApplicationRecord
  COMMENT_PARAMS = %i(content report_id).freeze

  belongs_to :report
  belongs_to :user

  validates :content, presence: true,
    length: {maximum: Settings.validates.comment.max_length}

  delegate :name, :avatar, to: :user, prefix: true

  after_commit :notify_new_comment

  scope :includes_user, ->{includes :user}
  scope :order_by_created_at, ->{order created_at: :desc}
  scope :by_report_id, ->(report_id){where(report_id: report_id)}

  private

  # rubocop:disable Style/RedundantSelf
  def notify_new_comment
    html = ApplicationController.render partial: "shared/report_comment",
                                        locals: {comment: self},
                                        formats: [:html]
    user_ids = commented_user_ids self.report_id
    user_ids.delete self.user_id
    user_ids.each do |user_id|
      new_comment_by_user = NewComment.by_user_id user_id
      create_new_comment_notify new_comment_by_user, self.report_id
      ActionCable.server.broadcast "comments_#{user_id}",
                                   html: html,
                                   report_id: self.report_id,
                                   num_of_notify: new_comment_by_user
                                     .by_checked(false)
                                     .count
    end
  end
  # rubocop:enable Style/RedundantSelf

  def create_new_comment_notify new_comment_by_user, report_id
    new_comment_by_user.by_report_id(report_id)
                       .first_or_create
                       .update checked: false
  end

  def commented_user_ids report_id
    Comment.by_report_id(report_id)
           .pluck(:user_id)
           .uniq
  end
end
