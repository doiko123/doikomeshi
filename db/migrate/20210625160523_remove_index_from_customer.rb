class RemoveIndexFromCustomer < ActiveRecord::Migration[6.1]
  def change
    remove_index :customers, :name
  end
end
