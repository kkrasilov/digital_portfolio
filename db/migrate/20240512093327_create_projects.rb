class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.string :urls, array: true, null: false, default: []


      t.timestamps
    end
  end
end
