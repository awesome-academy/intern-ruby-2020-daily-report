class AccountController < ApplicationController
  before_action :require_login

  def index
    @user = User.find_by id: current_user.id
    @division = Division.find_by id: current_user.division_id
  end

  def edit; end
end
