require 'rails_helper'

RSpec.describe "お知らせ表示機能", type: :model do
  it "お知らせ情報があれば有効であること" do
    article = build(:article)
    expect(article).to be_valid
  end

  it "お知らせタイトルがなければ無効な状態であること" do
    article = build(:article, title: nil)
    article.valid?
    expect(article.errors[:title]).to include("を入力してください")
  end

  it "お知らせ内容がなければ無効な状態であること" do
    article = build(:article, content: nil)
    article.valid?
    expect(article.errors[:content]).to include("を入力してください")
  end

  it "お知らせタイトルが50文字より多ければ無効な状態であること" do
    article = build(:article, title: "a" * 51)
    article.valid?
    expect(article.errors[:title]).to include("は50文字以内で入力してください")
  end
end
