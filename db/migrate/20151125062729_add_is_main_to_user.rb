class AddIsMainToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_main, :integer, default: 0
  end
end
