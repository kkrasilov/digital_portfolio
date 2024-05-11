class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :role, :string, null: false, default: :developer
    add_column :users, :admin, :boolean, null: false, default: false
    add_column :users, :admin_description, :string, null: false, default: ''
  end
end
