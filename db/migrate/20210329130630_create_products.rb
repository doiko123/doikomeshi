class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products, comment:'商品' do |t|
      t.string :stripe_id, null: false, comment: 'StripeのID'
      t.string :name, null: false, comment: '商品名'

      t.timestamps
    end
  end
end