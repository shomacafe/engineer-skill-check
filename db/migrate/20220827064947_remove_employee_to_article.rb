class RemoveEmployeeToArticle < ActiveRecord::Migration[6.1]
  def change
    remove_column :articles, :employee_id, :integer
  end
end
