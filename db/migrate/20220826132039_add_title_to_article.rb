class AddTitleToArticle < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :title, :string,   null: false
  end
end
