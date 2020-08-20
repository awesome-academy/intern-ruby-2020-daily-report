class Manager::ReportsController < ApplicationController
  before_action :require_login
  before_action :paginate_reports, only: %i(index update)
  before_action {check_role? :manager}

  def index; end

  def update
    Report.by_ids(params[:report_ids])
          .find_each &:checked!
    respond_to do |format|
      format.html{redirect_to manager_reports_path}
      format.js
    end
  end

  private

  def paginate_reports
    users = user_in_division
    @reports = Report.by_users(users)
                     .active_reports
                     .by_date_created(params[:date]&.first)
                     .by_status(params[:status])
                     .recent_reports
    @num_of_reports = @reports.size
    @reports = @reports.page(params[:page])
                       .per Settings.paginate.items_per_page
  end

  def user_in_division
    User.by_division_id(current_user.division_id)
        .like_email(params[:email])
        .like_name(params[:name])
  end
end
