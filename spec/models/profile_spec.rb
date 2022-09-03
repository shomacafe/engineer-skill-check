require 'rails_helper'

RSpec.describe "社員プロフィール", type: :model do
  it "プロフィール情報があれば有効であること" do
    profile = build(:profile)
    expect(profile).to be_valid
  end

  it "プロフィールがなければ無効であること" do
    profile = build(:profile, profile: nil)
    profile.valid?
    expect(profile.errors[:profile]).to include("を入力してください")
  end

  it "プロフィールが300文字より多ければ無効であること" do
    profile = build(:profile, profile: "a" * 301)
    profile.valid?
    expect(profile.errors[:profile]).to include("は300文字以内で入力してください")
  end
end

