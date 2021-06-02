class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders, comment:'注文' do |t|
      t.references :customer, foreign_key: true, null: false, comment: '顧客ID'
      t.references :sku, foreign_key: true, null: false, comment: 'SKUID'
      t.string :stripe_id, null: false, comment: 'StripeのID'

      t.timestamps
    end

    add_index :orders, :stripe_id, unique: true
  end
end