require 'rails_helper'

RSpec.describe "検索機能", type: :system do
  let(:employee) {create(:employee)}
  let!(:employee_a) { create(:employee, last_name: "鈴木") }
  let!(:employee_b) { create(:employee, last_name: "佐藤") }

  before do
    visit login_path
    fill_in "employees_account", with: employee.account
    fill_in "employees_password", with: employee.password
    click_button "ログイン"
    visit employees_path
    fill_in "q_first_name_or_last_name_cont", with: "鈴木"
    click_button "検索"
  end

  it "正しい検索結果を表示すること" do
    expect(page).to have_content "鈴木"
  end

  it "正しくない検索結果を表示しないこと" do
    expect(page).not_to have_content "佐藤"
  end
end
