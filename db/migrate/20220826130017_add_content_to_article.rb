class AddContentToArticle < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :title,      :string,   null: false
    add_column :articles, :content,    :text,     null: false
    add_column :articles, :author,     :integer,  null: false
    add_column :articles, :deleted_at, :datetime, null: true,   default: nil
  end
end
