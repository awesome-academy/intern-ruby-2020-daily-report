require "rails_helper"

RSpec.describe CommentsController, type: :controller do
  let!(:current_user){FactoryBot.create :user}

  describe "POST #create" do
    before {log_in current_user}

    context "when params is invalid" do
      before {post :create, params: {comment: {content: ""}}, xhr: true}

      it { expect(assigns :error).to eq(true) }
    end

    context "when params is valid" do
      let!(:report){FactoryBot.create :report, user_id: current_user.id}
      let!(:comments){FactoryBot.create_list :comment, Settings.rspec.factory_comments_size, report_id: report.id}
      let(:comment_params) {FactoryBot.attributes_for :comment, report_id: report.id, user_id: current_user.id}

      it do
        expect{
            post :create, params: comment_params, xhr: true
          }.to change(report.comments, :count).by(1)
      end
    end
  end
end
