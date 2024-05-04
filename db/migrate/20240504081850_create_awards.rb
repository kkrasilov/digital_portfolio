class CreateAwards < ActiveRecord::Migration[7.1]
  def change
    create_table :awards do |t|
      t.string :title, null: false, default: ''
      t.text :description, null: false, default: ''
      t.references :portfolio, foreign_key: true

      t.timestamps
    end
  end
end
