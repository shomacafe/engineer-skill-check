require 'rails_helper'

RSpec.describe "社員紹介機能", type: :model do
  it "社員情報があれば有効であること" do
    employee = build(:employee)
    expect(employee).to be_valid
  end

  it "部署がなければ無効な状態であること" do
    employee = build(:employee, department: nil)
    employee.valid?
    expect(employee.errors[:department]).to include("を入力してください")
  end

  it "オフィスがなければ無効な状態であること" do
    employee = build(:employee, office: nil)
    employee.valid?
    expect(employee.errors[:office]).to include("を入力してください")
  end

  it "社員番号がなければ無効な状態であること" do
    employee = build(:employee, number: nil)
    employee.valid?
    expect(employee.errors[:number]).to include("を入力してください")
  end

  it "氏名(姓)がなければ無効な状態であること" do
    employee = build(:employee, last_name: nil)
    employee.valid?
    expect(employee.errors[:last_name]).to include("を入力してください")
  end

  it "氏名(名)がなければ無効な状態であること" do
    employee = build(:employee, first_name: nil)
    employee.valid?
    expect(employee.errors[:first_name]).to include("を入力してください")
  end

  it "アカウントがなければ無効な状態であること" do
    employee = build(:employee, account: nil)
    employee.valid?
    expect(employee.errors[:account]).to include("を入力してください")
  end

  it "パスワードがなければ無効な状態であること" do
    employee = build(:employee, password: nil)
    employee.valid?
    expect(employee.errors[:password]).to include("を入力してください")
  end

  it "メールアドレスがなければ無効な状態であること" do
    employee = build(:employee, email: nil)
    employee.valid?
    expect(employee.errors[:email]).to include("を入力してください")
  end

  it "入社年月日がなければ無効な状態であること" do
    employee = build(:employee, date_of_joining: nil)
    employee.valid?
    expect(employee.errors[:date_of_joining]).to include("を入力してください")
  end

  it "社員番号が重複していれば無効な状態であること" do
    employee_1 = create(:employee, number: 2)
    employee_2 = build(:employee, number: 2)
    employee_2.valid?
    expect(employee_2.errors[:number]).to include("はすでに存在します")
  end

  it "アカウントが重複していれば無効な状態であること" do
    employee_1 = create(:employee, account: "suzuki")
    employee_2 = build(:employee, account: "suzuki")
    employee_2.valid?
    expect(employee_2.errors[:account]).to include("はすでに存在します")
  end
end
