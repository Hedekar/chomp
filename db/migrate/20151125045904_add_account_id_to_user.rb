class AddAccountIdToUser < ActiveRecord::Migration
  def change
    add_reference :users, :account, index: true
  end
end
