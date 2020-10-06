require "rails_helper"

RSpec.describe Manager::ReportsController, type: :controller do
  context "when user do not log in" do
    describe "GET #index" do
      before {get :index, params: {locale: "en"}}

      it { expect(response).to redirect_to new_user_session_path }
    end

    describe "GET #show" do
      let(:report){FactoryBot.create :report}

      before {get :show, params: {locale: "en", id: report.id}}

      it { expect(response).to redirect_to new_user_session_path }
    end
  end

  context "when user logged in" do
    context "when user logged in as manager" do
      let!(:current_user){FactoryBot.create :user, role: 1}
      let(:reports){FactoryBot.create_list :report, Settings.rspec.factory_reports_size, user_id: current_user.id}

      before {log_in current_user}

      describe "GET #index" do
        context "when do not have any params" do
          before {get :index}

          it { expect(assigns :reports).to eq(reports.reverse.slice(0, Settings.paginate.items_per_page)) }
        end

        context "when have params per_page" do
          before {get :index, params: {per_page: 30}}

          it { expect(assigns :reports).to eq(reports.reverse.slice(0, 30)) }
        end

        context "when have params show_all" do
          before {get :index, params: {show_all: true}}

          it { expect(assigns :reports).to eq(reports.reverse) }
        end

        context "when have filter params" do
          before {get :index, params: {q: {status_eq: Settings.reports.status.waiting}}}

          it { expect(assigns :reports).to eq(Report.waiting.recent_reports.slice(0, Settings.paginate.items_per_page)) }
        end
      end

      describe "PUT #update" do
        let!(:report){FactoryBot.create :report}

        before {put :update, params: {report_ids: [report.id], update_status: Settings.rspec.report.rejected}, xhr: true}

        it do
          report.reload
          expect(report.rejected?).to eq(true)
        end
      end

      describe "GET #show" do
        let!(:report){FactoryBot.create :report}
        let(:comments){FactoryBot.create_list :comment, Settings.rspec.factory_comments_size, report_id: report.id}

        context "when report_id is valid" do
          before {get :show, params: {id: report.id}}

          it { expect(assigns :user).to eq(report.user) }

          it { expect(assigns :comments).to eq(comments.reverse) }
        end

        context "when report_id is invalid" do
          before {get :show, params: {id: Settings.rspec.invalid_id}}

          it { expect(flash[:danger]).to eq I18n.t("manager.reports.show.find_report_error") }

          it { expect(response).to redirect_to reports_path }
        end
      end
    end

    context "when user logged in as member" do
      let(:current_user){FactoryBot.create :user}

      before {log_in current_user}

      describe "GET #index" do
        before {get :index, params: {locale: "en"}}

        it { expect(response).to redirect_to root_path }
      end

      describe "GET #show" do
        let(:report){FactoryBot.create :report}

        before {get :show, params: {locale: "en", id: report.id}}

        it { expect(response).to redirect_to root_path }
      end
    end
  end
end
