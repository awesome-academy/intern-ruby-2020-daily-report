class UsersController < ApplicationController
  def new
    @user = User.new
    redirect_root
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:info] = t ".signup_success_notify"
      log_in @user
      redirect_to root_url
    else
      flash.now[:danger] = t ".signup_faild_notify"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit User::USERS_PARAMS
  end
end
