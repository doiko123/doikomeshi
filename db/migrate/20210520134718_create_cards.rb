class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards, comment:'クレジットカード' do |t|
      t.references :customer, null: false, comment: '顧客ID'
      t.string :stripe_id, null: false, comment: 'StripeのID'
      t.string :last4, null: false, comment: 'カード下4桁'
      t.integer :exp_month, null: false, comment: '有効期限の月'
      t.integer :exp_year, null: false, comment: '有効期限の年'
      t.string :brand, null: false, comment: 'カードのブランド'

      t.timestamps
    end

    add_index :cards, :stripe_id, unique: true
  end
end
