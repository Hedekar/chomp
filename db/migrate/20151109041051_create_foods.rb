class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :name
      t.date :date
      t.float :serving
      t.integer :category
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
