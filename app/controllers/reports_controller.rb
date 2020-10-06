class ReportsController < ApplicationController
  before_action ->{check_role? :member}
  before_action :paginate_reports, only: %i(index destroy)
  before_action :find_report, except: %i(new create index)
  before_action :belong_to_division?, only: %i(new create)
  before_action :today_reports, only: :new

  def index; end

  def new
    return @report = current_user.reports.build if @today_reports.blank?

    flash[:danger] = t ".error_create_path"
    redirect_to reports_path
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

  def show
    checked_new_comment params[:id]
    @user = @report.user
    @comments = Comment.includes_user
                       .by_report_id(params[:id])
                       .order_by_created_at
  end

  def update
    if @report.update report_params
      flash[:success] = t ".edit_report_success"
      redirect_to reports_path
    else
      flash[:danger] = t ".edit_report_faild"
      redirect_to edit_report_path params[:id]
    end
  end

  def edit; end

  def destroy
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
    select_reports
    per_page = params[:per_page].presence || Settings.paginate.per_page_default
    @reports = @reports.page(params[:page])
                       .per per_page
  end

  def find_report
    @report = Report.find_by id: params[:id]
    return if @report

    flash[:danger] = t ".find_report_error"
    redirect_to reports_path
  end

  def today_reports
    @today_reports = Report.by_users(current_user.id)
                           .by_date_created(Date.current)
                           .active_reports
  end

  def select_reports
    @report = Report.ransack params[:q]
    @reports = @report.result
                      .by_users(current_user.id)
                      .active_reports
                      .recent_reports
  end
end
