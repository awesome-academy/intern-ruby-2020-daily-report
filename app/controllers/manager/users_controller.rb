class Manager::UsersController < ApplicationController
  before_action :require_login, -> {check_role? :manager}
  before_action :find_user, only: %i(show update)
  before_action :paginate_members, only: %i(index update)

  def index; end

  def show
    @division = Division.find_by id: @user.division_id
    return if @division

    flash[:danger] = t ".error_division"
    redirect_to manager_users_path
  end

  def update
    if params[:nonremote]
      update_user_nonremote
      redirect_to manager_user_path params[:id]
    else
      @user.update division_id: Settings.division.default
      respond_to do |format|
        format.html{redirect_to manager_users_path}
        format.js
      end
    end
  end

  private

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t ".find_user_error"
    redirect_to manager_users_path
  end

  def paginate_members
    @members = User.by_division_id(current_user.division_id)
                   .member
                   .page(params[:page])
                   .per Settings.paginate.items_per_page
    @managers = User.by_division_id(current_user.division_id)
                    .manager
  end

  def update_user_nonremote
    division_id = @user.division_id.eql?(Settings.division.default) ? current_user.division_id : Settings.division.default
    @user.update division_id: division_id
  end
end
