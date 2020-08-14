class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :set_locale

  private

  def redirect_root
    return unless logged_in?

    redirect_to root_path
  end

  def redirect_login
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
