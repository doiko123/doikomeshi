class CreateSkus < ActiveRecord::Migration[6.1]
  def change
    create_table :skus, comment: 'SKU' do |t|
      t.string :stripe_id, null: false, comment: 'StripeのID'
      t.references :product, foreign_key: true, null: false, comment: '商品ID'
      t.integer :price, null: false, comment: '価格'

      t.timestamps
    end

    add_index :skus, :stripe_id, unique: true
  end
end
