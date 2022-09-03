FactoryBot.define do
  factory :employee do
    number { 1 }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { "パスワード" }
    last_name { "氏名(姓)" }
    first_name { "氏名(名)" }
    account { "アカウント" }
    date_of_joining { "2022-09-19" }
    association :department
    association :office
  end
end
