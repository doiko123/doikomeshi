class CreateSkus < ActiveRecord::Migration[6.1]
  def change
    create_table :skus, comment: 'SKU' do |t|
      t.integer :price, null: false, comment: '価格'

      t.timestamps
    end
  end
end
