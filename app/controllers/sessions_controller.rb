class SessionsController < ApplicationController
  def new
    redirect_root
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      flash[:success] = t ".login_success_notify"
      log_in user
      redirect_to root_path
    else
      flash.now[:danger] = t ".ivalid_account_notify"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to login_path
  end
end
