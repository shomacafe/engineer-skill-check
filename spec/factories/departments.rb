FactoryBot.define do
  factory :department do
    id { |n| "#{n}" }
    name { "部署名" }
  end
end
