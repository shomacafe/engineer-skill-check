require 'rails_helper'

RSpec.describe "社員紹介機能", type: :system do
  let(:employee_a) { create(:employee, last_name: "社員A") }
  let(:employee_b) { create(:employee, last_name: "社員B", employee_info_manage_auth: "false") }

  before do
    visit login_path
    fill_in "employees_account", with: employee.account
    fill_in "employees_password", with: employee.password
    click_button "ログイン"
  end

  context "社員A(管理権限あり)がログインしているとき" do
    let(:employee) { employee_a }

    it "社員番号が表示されること" do
      expect(page).to have_content employee.number
    end

    it "社員名が表示されること" do
      expect(page).to have_content "社員A"
      expect(page).to have_content employee.first_name
    end

    it "部署が表示されること" do
      expect(page).to have_content employee.department.name
    end

    it "新規追加ボタンが表示されること" do
      expect(page).to have_selector ".new_employee", text: "新規追加"
    end

    it "csv出力ボタンが表示されること" do
      expect(page).to have_selector ".new_employee", text: "csvで出力する"
    end

    it "編集/削除ボタンが表示されること" do
      expect(page).to have_selector ".editDelete", text: "編集"
      expect(page).to have_selector ".editDelete", text: "削除"
    end
  end

  context "社員B(管理権限なし)がログインしているとき" do
    let(:employee) { employee_b }

    it "新規追加ボタンが表示されないこと" do
      expect(page).not_to have_selector ".new_employee", text: "新規追加"
    end

    it "csv出力ボタンが表示されないこと" do
      expect(page).not_to have_selector ".new_employee", text: "csvで出力する"
    end

    it "編集/削除ボタンが表示されないこと" do
      expect(page).not_to have_selector ".editDelete", text: "編集"
      expect(page).not_to have_selector ".editDelete", text: "削除"
    end
  end
end
