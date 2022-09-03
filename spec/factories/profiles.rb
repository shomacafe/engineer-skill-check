FactoryBot.define do
  factory :profile do
    profile { "社員プロフィールです。" }
    association :employee
  end
end
