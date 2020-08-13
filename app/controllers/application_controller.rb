class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :set_locale

  private

  def check_role? role
    return if current_user.send("#{role}?")

    redirect_to root_path
  end

  def belong_to_division?
    return unless current_user.division_id.eql? Settings.division.default

    redirect_to report_path current_user
  end

  def redirect_root
    return unless logged_in?

    redirect_to root_path
  end

  def require_login
    return if logged_in?

    redirect_to login_path
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
