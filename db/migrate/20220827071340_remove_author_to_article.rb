class RemoveAuthorToArticle < ActiveRecord::Migration[6.1]
  def change
    remove_column :articles, :author, :integer
  end
end
