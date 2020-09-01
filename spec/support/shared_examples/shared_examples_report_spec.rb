RSpec.shared_examples "create example reports" do
  let!(:report1) {FactoryBot.create(:report, status: Settings.reports.status.waiting, deleted: true)}
  let!(:report2) {FactoryBot.create(:report, status: Settings.reports.status.checked, deleted: false)}
  let!(:report3) {FactoryBot.create(:report, status: Settings.reports.status.rejected, deleted: false)}
  let!(:report4) {FactoryBot.create(:report, status: Settings.reports.status.waiting, deleted: false)}
end
