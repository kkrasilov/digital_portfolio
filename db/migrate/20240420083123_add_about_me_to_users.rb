class AddAboutMeToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :about_me, :text, null: false, default: ''
  end
end
