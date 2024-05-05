class CreatePortfolios < ActiveRecord::Migration[7.1]
  def change
    create_table :portfolios do |t|
      t.string :title, null: false, default: ''
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
