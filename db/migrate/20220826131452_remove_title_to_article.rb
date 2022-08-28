class RemoveTitleToArticle < ActiveRecord::Migration[6.1]
  def change
    remove_column :articles, :title, :string
    remove_column :articles, :text,  :string
  end
end
