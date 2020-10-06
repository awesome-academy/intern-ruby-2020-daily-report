require "rails_helper"

RSpec.describe AccountController, type: :controller do
  let!(:division){FactoryBot.create :division}
  let(:current_user){FactoryBot.create :user, division_id: division.id}
  let(:user_params) {FactoryBot.attributes_for :user, division_id: division.id}

  context "when user does not login" do
    describe "GET #index" do
      before {get :index, params: {locale: "en"}}

      it { expect(response).to redirect_to new_user_session_path }
    end

    describe "GET #edit" do
      before {get :edit, params: {id: current_user.id, locale: "en"}}

      it { expect(response).to redirect_to new_user_session_path }
    end
  end

  context "when user logged in" do
    before {log_in current_user}

    describe "GET #index" do
      before {get :index}

      it { expect(assigns :user).to eq(current_user) }

      it { expect(assigns :division).to eq(division)}
    end

    describe "GET #edit" do
      before {get :edit, params: {id: current_user.id}}

      it { expect(assigns :user).to eq(current_user) }

      it { expect(assigns :division).to eq(division)}
    end

    describe "PUT #update" do
      context "when params is valid" do
        before {put :update, params: {id: current_user.id, user: user_params}}

        it { expect(response).to redirect_to account_index_path }

        it { expect(flash[:success]).to eq I18n.t("account.update_success") }
      end

      context "when params is invalid" do
        before {put :update, params: {id: current_user.id, user: user_params, email: ""}}

        it { expect(response).to redirect_to edit_account_path current_user }

        it { expect(flash[:danger]).to eq I18n.t("account.update_faild") }
      end
    end
  end
end
