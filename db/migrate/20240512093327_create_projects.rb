class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.integer :progress
      t.text :status, null: false, default: 'draft'
      t.text :base_url
      t.text :code_url
      t.text :short_description

      t.timestamps
    end
  end
end
