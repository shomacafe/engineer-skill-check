FactoryBot.define do
  factory :article do
    title { "お知らせタイトル" }
    content { "お知らせ内容" }
    created_at { "投稿日" }
    association :employee
  end
end
