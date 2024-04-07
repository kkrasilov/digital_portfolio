class CreateLogInfos < ActiveRecord::Migration[7.1]
  def change
    create_table :log_infos do |t|
      t.string :title, null: false, default: ''
      t.string :log_type, null: false, default: :info
      t.jsonb :data, null: false, default: {}

      t.timestamps
    end
  end
end
