class CreateWeights < ActiveRecord::Migration
  def change
    create_table :weights do |t|
      t.integer :Weight
      t.string :Units
      t.timestamp :Date
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :weights, [:user_id, :created_at]
  end
end
