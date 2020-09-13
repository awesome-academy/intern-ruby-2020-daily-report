require "rails_helper"

RSpec.describe Report, type: :model do
  describe "Enums" do
    it { is_expected.to define_enum_for(:status).with_values([:waiting, :checked, :rejected]) }
  end

  describe "Associations" do
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to belong_to(:user) }
  end

  describe "Validations" do
    context "when all fields given" do
      let(:report) {FactoryBot.create :report}

      it { expect(report.valid?).to eq true }
    end

    context "when all fields missing" do
      let(:report) {FactoryBot.build :report, today_plan: "", actual: "", tomorrow_plan: ""}

      it { expect(report.valid?).to eq false }
    end

    context "when today_plan missing" do
      let(:report_fail) {FactoryBot.build :report, today_plan: ""}

      it { expect(report_fail.valid?).to eq false }
    end

    context "when actual missing" do
      let(:report_fail) {FactoryBot.build :report, actual: ""}

      it { expect(report_fail.valid?).to eq false }
    end

    context "when tomorrow_plan missing" do
      let(:report_fail) {FactoryBot.build :report, tomorrow_plan: ""}

      it { expect(report_fail.valid?).to eq false }
    end
  end

  describe "Scopes" do
    include_examples "create example reports"

    describe ".recent_reports" do
      it { expect(Report.recent_reports).to eq([report4, report3, report2, report1]) }
    end

    describe ".active_reports" do
      it { expect(Report.active_reports.size).to eq(3) }
    end

    describe ".by_ids" do
      it { expect(Report.by_ids(2)).to eq(Report.where(id: 2)) }
    end

    describe ".by_users" do
      it { expect(Report.by_users(1)).to eq(Report.where(user_id: 1)) }
    end

    describe ".order_by_created" do
      context "when order by desc" do
        it { expect(Report.order_by_created(:desc)).to eq([report4, report3, report2, report1]) }
      end

      context "when order by nil" do
        it { expect(Report.order_by_created(nil)).to eq([report4, report3, report2, report1]) }
      end

      context "when order by asc" do
        it { expect(Report.order_by_created(:asc)).to eq([report1, report2, report3, report4]) }
      end
    end

    describe ".order_by_status" do
      context "when order by asc" do
        it { expect(Report.order_by_status(:asc)).to eq([report1, report4, report2, report3]) }
      end

      context "when order by nil" do
        it { expect(Report.order_by_status(nil)).to eq([report1, report4, report2, report3]) }
      end

      context "when order by desc" do
        it { expect(Report.order_by_status(:desc)).to eq([report3, report2, report1, report4]) }
      end
    end
  end
end
