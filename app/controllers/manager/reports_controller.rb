class Manager::ReportsController < ApplicationController
  before_action :require_login, ->{check_role? :manager}
  before_action :paginate_reports, only: %i(index update)
  before_action :find_report, only: :show

  def index; end

  def update
    Report.by_ids(params[:report_ids])
          .find_each &:checked!
    respond_to do |format|
      format.html{redirect_to manager_reports_path}
      format.js
    end
  end

  def show
    @user = @report.user
    @comments = Comment.by_report_id(params[:id])
                       .order_by_created_at
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

  def find_report
    @report = Report.find_by id: params[:id]
    return if @report

    flash[:danger] = t ".find_report_error"
    redirect_to reports_path
  end
end
