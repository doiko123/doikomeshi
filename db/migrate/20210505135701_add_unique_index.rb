class AddUniqueIndex < ActiveRecord::Migration[6.1]
  def change
    add_index :customers, :name, unique: true
    add_index :customers, :stripe_id, unique: true
    add_index :customers, :email, unique: true
    add_index :products, :name, unique: true
    add_index :products, :stripe_id, unique: true
  end
end
