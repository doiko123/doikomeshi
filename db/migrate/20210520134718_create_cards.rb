class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.integer :customer_id
      t.string :stripe_id
      t.string :last4
      t.integer :exp_month
      t.integer :exp_year
      t.string :brand

      t.timestamps
    end
  end
end
