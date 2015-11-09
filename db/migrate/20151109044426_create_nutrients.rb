class CreateNutrients < ActiveRecord::Migration
  def change
    create_table :nutrients do |t|
      t.integer :ref_id
      t.string :name
      t.string :group
      t.string :unit
      t.float :value
      t.belongs_to :food, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
