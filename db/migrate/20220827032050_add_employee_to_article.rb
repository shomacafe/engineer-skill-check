class AddEmployeeToArticle < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :employee_id, :integer
  end
end
