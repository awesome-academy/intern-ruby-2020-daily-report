class Manager::ReportsController < ApplicationController
  before_action ->{check_role? :manager}
  before_action :paginate_reports, only: %i(index update)
  before_action :find_report, only: :show

  def index; end

  # rubocop:disable Rails/SkipsModelValidations
  def update
    Report.by_ids(params[:report_ids])
          .update_all status: params[:update_status]
    respond_to do |format|
      format.html{redirect_to manager_reports_path}
      format.js
    end
  end
  # rubocop:enable Rails/SkipsModelValidations

  def show
    @user = @report.user
    @comments = Comment.includes_user
                       .by_report_id(params[:id])
                       .order_by_created_at
  end

  private

  def paginate_reports
    select_reports
    per_page = params[:per_page].presence || Settings.paginate.per_page_default
    @reports = @reports.page(params[:page])
                       .per per_page
    return unless params[:show_all]

    @reports = @reports.except :limit, :offset
  end

  def user_in_division
    User.by_division_id(current_user.division_id)
  end

  def find_report
    @report = Report.find_by id: params[:id]
    return if @report

    flash[:danger] = t ".find_report_error"
    redirect_to reports_path
  end

  def select_reports
    users = user_in_division
    @report = Report.ransack params[:q]
    @reports = @report.result
                      .includes(:user)
                      .by_users(users)
                      .active_reports
    return if @report.sorts.present?

    @reports = @reports.order_by_status(:asc)
                       .order_by_created :desc
  end
end
