class AccountController < ApplicationController
  before_action :require_login
  before_action :user_info, only: %i(index edit update)

  def index; end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t ".update_success"
      redirect_to account_index_path
    else
      flash[:danger] = t ".update_faild"
      redirect_to edit_account_path current_user
    end
  end

  private

  def user_params
    params.permit User::USERS_PARAMS
  end

  def user_info
    @user = User.find_by id: current_user.id
    @division = Division.find_by id: current_user.division_id
  end
end
