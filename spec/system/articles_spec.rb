require 'rails_helper'

RSpec.describe "お知らせ表示機能", type: :system do
  let(:employee_a) { create(:employee, last_name: "社員A") }
  let(:employee_b) { create(:employee, last_name: "社員B") }
  let(:employee_c) { create(:employee, last_name: "社員C", news_posting_auth: "false") }
  let!(:article) { create(:article, title: "既存のお知らせ") }

  before do
    visit login_path
    fill_in "employees_account", with: employee.account
    fill_in "employees_password", with: employee.password
    click_button "ログイン"
  end

  context "社員A(お知らせ投稿あり)がログインしているとき" do
    let(:employee) { employee_a }

    before do
      visit new_article_path
      fill_in "article_title", with: "お知らせタイトルA"
      fill_in "article_content", with: "お知らせ内容A"
      click_button "保存する"
    end
    
    it "お知らせタイトルが表示されること" do
      expect(page).to have_content "既存のお知らせ"
    end

    it "自分の投稿したお知らせタイトルが表示されること" do
      expect(page).to have_content "お知らせタイトルA"
    end

    it "新規追加ボタンが表示されること" do
      expect(page).to have_selector ".new_employee", text: "新規追加"
    end

    it "編集/削除ボタンが表示されること" do
      expect(page).to have_selector ".article_btn_name", text: "編集"
      expect(page).to have_selector ".article_btn_name", text: "削除"
    end
  end

  context "社員B(お知らせ投稿なし)がログインしているとき" do
    let(:employee) { employee_b }

    before do
      visit articles_path
    end
    
    it "お知らせタイトルが表示されること" do
      expect(page).to have_content "既存のお知らせ"
    end

    it "新規追加ボタンが表示されること" do
      expect(page).to have_selector ".new_employee", text: "新規追加"
    end

    it "編集/削除ボタンが表示されないこと" do
      expect(page).not_to have_selector ".article_btn_name", text: "編集"
      expect(page).not_to have_selector ".article_btn_name", text: "削除"
    end
  end

  context "社員C(管理権限なし)がログインしているとき" do
    let(:employee) { employee_c }

    before do
      visit articles_path
    end

    it "お知らせタイトルが表示されること" do
      expect(page).to have_content "既存のお知らせ"
    end

    it "新規追加ボタンが表示されないこと" do
      expect(page).not_to have_selector ".new_employee", text: "新規追加"
    end
  end
end
