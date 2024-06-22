class AddNewFieldsToProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :projects, :technologies, :string
  end
end
