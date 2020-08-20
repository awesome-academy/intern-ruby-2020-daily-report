class ReportsController < ApplicationController
  before_action :require_login
  before_action :paginate_reports, only: %i(index update)
  before_action :find_report, only: :update
  before_action :belong_to_division?, only: %i(new create)
  before_action {check_role? :member}

  def index; end

  def new
    @report = current_user.reports.build
  end

  def create
    @report = current_user.reports.build report_params

    if @report.save
      flash[:info] = t ".create_success_notify"
      redirect_to reports_path
    else
      flash.now[:danger] = t ".create_failed_notify"
      render :new
    end
  end

  def update
    @report.update deleted: true
    respond_to do |format|
      format.html{redirect_to reports_path}
      format.js
    end
  end

  private

  def report_params
    params.require(:report).permit Report::REPORTS_PARAMS
  end

  def paginate_reports
    @reports = Report.by_users(current_user.id)
                     .active_reports
                     .by_date_created(params[:date]&.first)
                     .by_status(params[:status])
                     .recent_reports
    @num_of_reports = @reports.size
    @reports = @reports.page(params[:page])
                       .per Settings.paginate.items_per_page
  end

  def find_report
    @report = Report.find_by id: params[:id]
    return if @report

    flash[:danger] = t ".find_report_error"
    redirect_to reports_path
  end
end
