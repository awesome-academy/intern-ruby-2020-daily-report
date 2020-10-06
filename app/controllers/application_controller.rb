class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i(name email password))
  end

  private

  def check_role? role
    return if current_user.send("#{role}?")

    redirect_to root_path
  end

  def belong_to_division?
    return unless current_user.division_id.eql? Settings.division.default

    redirect_to report_path current_user
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def checked_new_comment report_id
    current_user.new_comments
                .by_report_id(report_id)
                .update checked: true
  end

  def new_comment_notify user_id
    NewComment.by_user_id(user_id)
              .by_checked false
  end
end
